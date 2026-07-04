// Tvmaze Ts SDK

import { AkaEntity } from './entity/AkaEntity'
import { AlternateListEntity } from './entity/AlternateListEntity'
import { CastEntity } from './entity/CastEntity'
import { CastCreditEntity } from './entity/CastCreditEntity'
import { CastMemberEntity } from './entity/CastMemberEntity'
import { CrewEntity } from './entity/CrewEntity'
import { CrewCreditEntity } from './entity/CrewCreditEntity'
import { CrewMemberEntity } from './entity/CrewMemberEntity'
import { EpisodeEntity } from './entity/EpisodeEntity'
import { GuestCastCreditEntity } from './entity/GuestCastCreditEntity'
import { ImageEntity } from './entity/ImageEntity'
import { PersonEntity } from './entity/PersonEntity'
import { ScheduleEntity } from './entity/ScheduleEntity'
import { ScheduledEpisodeEntity } from './entity/ScheduledEpisodeEntity'
import { SearchEntity } from './entity/SearchEntity'
import { SeasonEntity } from './entity/SeasonEntity'
import { ShowEntity } from './entity/ShowEntity'
import { UpdateEntity } from './entity/UpdateEntity'

export type * from './TvmazeTypes'


import { inspect } from 'node:util'

import type { Context, Feature } from './types'

import { config } from './Config'
import { TvmazeEntityBase } from './TvmazeEntityBase'
import { Utility } from './utility/Utility'


import { BaseFeature } from './feature/base/BaseFeature'


const stdutil = new Utility()


class TvmazeSDK {
  _mode: string = 'live'
  _options: any
  _utility = new Utility()
  _features: Feature[]
  _rootctx: Context

  constructor(options?: any) {

    this._rootctx = this._utility.makeContext({
      client: this,
      utility: this._utility,
      config,
      options,
      shared: new WeakMap()
    })

    this._options = this._utility.makeOptions(this._rootctx)

    const struct = this._utility.struct
    const getpath = struct.getpath
    const items = struct.items

    if (true === getpath(this._options.feature, 'test.active')) {
      this._mode = 'test'
    }

    this._rootctx.options = this._options

    this._features = []

    const featureAdd = this._utility.featureAdd
    const featureInit = this._utility.featureInit

    items(this._options.feature, (fitem: [string, any]) => {
      const fname = fitem[0]
      const fopts = fitem[1]
      if (fopts.active) {
        featureAdd(this._rootctx, this._rootctx.config.makeFeature(fname))
      }
    })

    if (null != this._options.extend) {
      for (let f of this._options.extend) {
        featureAdd(this._rootctx, f)
      }
    }

    for (let f of this._features) {
      featureInit(this._rootctx, f)
    }

    const featureHook = this._utility.featureHook
    featureHook(this._rootctx, 'PostConstruct')
  }


  options() {
    return this._utility.struct.clone(this._options)
  }


  utility() {
    return this._utility.struct.clone(this._utility)
  }


  async prepare(fetchargs?: any) {
    const utility = this._utility
    const struct = utility.struct
    const clone = struct.clone

    const {
      makeContext,
      makeFetchDef,
      prepareHeaders,
      prepareAuth,
    } = utility

    fetchargs = fetchargs || {}

    let ctx: Context = makeContext({
      opname: 'prepare',
      ctrl: fetchargs.ctrl || {},
    }, this._rootctx)

    const options = this._options

    // Build spec directly from SDK options + user-provided fetch args.
    const spec: any = {
      base: options.base,
      prefix: options.prefix,
      suffix: options.suffix,
      path: fetchargs.path || '',
      method: fetchargs.method || 'GET',
      params: fetchargs.params || {},
      query: fetchargs.query || {},
      headers: prepareHeaders(ctx),
      body: fetchargs.body,
      step: 'start',
    }

    ctx.spec = spec

    // Merge user-provided headers over SDK defaults.
    if (fetchargs.headers) {
      const uheaders = fetchargs.headers
      for (let key in uheaders) {
        spec.headers[key] = uheaders[key]
      }
    }

    // Apply SDK auth (apikey, auth prefix, etc.)
    const authResult = prepareAuth(ctx)
    if (authResult instanceof Error) {
      return authResult
    }

    return makeFetchDef(ctx)
  }


  async direct(fetchargs?: any) {
    const utility = this._utility
    const fetcher = utility.fetcher
    const makeContext = utility.makeContext

    const fetchdef = await this.prepare(fetchargs)
    if (fetchdef instanceof Error) {
      return fetchdef
    }

    let ctx: Context = makeContext({
      opname: 'direct',
      ctrl: (fetchargs || {}).ctrl || {},
    }, this._rootctx)

    try {
      const fetched = await fetcher(ctx, fetchdef.url, fetchdef)

      if (null == fetched) {
        return { ok: false, err: ctx.error('direct_no_response', 'response: undefined') }
      }
      else if (fetched instanceof Error) {
        return { ok: false, err: fetched }
      }

      const status = fetched.status

      // No body responses (204 No Content, 304 Not Modified) and explicit
      // zero content-length must skip JSON parsing — fetched.json() would
      // throw `Unexpected end of JSON input` on an empty body.
      const headers = fetched.headers
      const contentLength = headers && 'function' === typeof headers.get
        ? headers.get('content-length')
        : (headers || {})['content-length']
      const noBody = 204 === status || 304 === status || '0' === String(contentLength)

      let json: any = undefined
      if (!noBody) {
        try {
          json = 'function' === typeof fetched.json ? await fetched.json() : fetched.json
        }
        catch (parseErr) {
          // Body wasn't valid JSON — surface the raw response rather than
          // throwing. data stays undefined; callers can inspect status/headers.
          json = undefined
        }
      }

      return {
        ok: status >= 200 && status < 300,
        status,
        headers: fetched.headers,
        data: json,
      }
    }
    catch (err: any) {
      return { ok: false, err }
    }
  }



  _aka?: AkaEntity

  // Idiomatic facade: `client.aka.list()` / `client.aka.load({ id })`.
  get aka(): AkaEntity {
    return (this._aka ??= new AkaEntity(this, undefined))
  }

  /** @deprecated Use `client.aka` instead. */
  Aka(data?: any) {
    const self = this
    return new AkaEntity(self,data)
  }


  _alternate_list?: AlternateListEntity

  // Idiomatic facade: `client.alternate_list.list()` / `client.alternate_list.load({ id })`.
  get alternate_list(): AlternateListEntity {
    return (this._alternate_list ??= new AlternateListEntity(this, undefined))
  }

  /** @deprecated Use `client.alternate_list` instead. */
  AlternateList(data?: any) {
    const self = this
    return new AlternateListEntity(self,data)
  }


  _cast?: CastEntity

  // Idiomatic facade: `client.cast.list()` / `client.cast.load({ id })`.
  get cast(): CastEntity {
    return (this._cast ??= new CastEntity(this, undefined))
  }

  /** @deprecated Use `client.cast` instead. */
  Cast(data?: any) {
    const self = this
    return new CastEntity(self,data)
  }


  _cast_credit?: CastCreditEntity

  // Idiomatic facade: `client.cast_credit.list()` / `client.cast_credit.load({ id })`.
  get cast_credit(): CastCreditEntity {
    return (this._cast_credit ??= new CastCreditEntity(this, undefined))
  }

  /** @deprecated Use `client.cast_credit` instead. */
  CastCredit(data?: any) {
    const self = this
    return new CastCreditEntity(self,data)
  }


  _cast_member?: CastMemberEntity

  // Idiomatic facade: `client.cast_member.list()` / `client.cast_member.load({ id })`.
  get cast_member(): CastMemberEntity {
    return (this._cast_member ??= new CastMemberEntity(this, undefined))
  }

  /** @deprecated Use `client.cast_member` instead. */
  CastMember(data?: any) {
    const self = this
    return new CastMemberEntity(self,data)
  }


  _crew?: CrewEntity

  // Idiomatic facade: `client.crew.list()` / `client.crew.load({ id })`.
  get crew(): CrewEntity {
    return (this._crew ??= new CrewEntity(this, undefined))
  }

  /** @deprecated Use `client.crew` instead. */
  Crew(data?: any) {
    const self = this
    return new CrewEntity(self,data)
  }


  _crew_credit?: CrewCreditEntity

  // Idiomatic facade: `client.crew_credit.list()` / `client.crew_credit.load({ id })`.
  get crew_credit(): CrewCreditEntity {
    return (this._crew_credit ??= new CrewCreditEntity(this, undefined))
  }

  /** @deprecated Use `client.crew_credit` instead. */
  CrewCredit(data?: any) {
    const self = this
    return new CrewCreditEntity(self,data)
  }


  _crew_member?: CrewMemberEntity

  // Idiomatic facade: `client.crew_member.list()` / `client.crew_member.load({ id })`.
  get crew_member(): CrewMemberEntity {
    return (this._crew_member ??= new CrewMemberEntity(this, undefined))
  }

  /** @deprecated Use `client.crew_member` instead. */
  CrewMember(data?: any) {
    const self = this
    return new CrewMemberEntity(self,data)
  }


  _episode?: EpisodeEntity

  // Idiomatic facade: `client.episode.list()` / `client.episode.load({ id })`.
  get episode(): EpisodeEntity {
    return (this._episode ??= new EpisodeEntity(this, undefined))
  }

  /** @deprecated Use `client.episode` instead. */
  Episode(data?: any) {
    const self = this
    return new EpisodeEntity(self,data)
  }


  _guest_cast_credit?: GuestCastCreditEntity

  // Idiomatic facade: `client.guest_cast_credit.list()` / `client.guest_cast_credit.load({ id })`.
  get guest_cast_credit(): GuestCastCreditEntity {
    return (this._guest_cast_credit ??= new GuestCastCreditEntity(this, undefined))
  }

  /** @deprecated Use `client.guest_cast_credit` instead. */
  GuestCastCredit(data?: any) {
    const self = this
    return new GuestCastCreditEntity(self,data)
  }


  _image?: ImageEntity

  // Idiomatic facade: `client.image.list()` / `client.image.load({ id })`.
  get image(): ImageEntity {
    return (this._image ??= new ImageEntity(this, undefined))
  }

  /** @deprecated Use `client.image` instead. */
  Image(data?: any) {
    const self = this
    return new ImageEntity(self,data)
  }


  _person?: PersonEntity

  // Idiomatic facade: `client.person.list()` / `client.person.load({ id })`.
  get person(): PersonEntity {
    return (this._person ??= new PersonEntity(this, undefined))
  }

  /** @deprecated Use `client.person` instead. */
  Person(data?: any) {
    const self = this
    return new PersonEntity(self,data)
  }


  _schedule?: ScheduleEntity

  // Idiomatic facade: `client.schedule.list()` / `client.schedule.load({ id })`.
  get schedule(): ScheduleEntity {
    return (this._schedule ??= new ScheduleEntity(this, undefined))
  }

  /** @deprecated Use `client.schedule` instead. */
  Schedule(data?: any) {
    const self = this
    return new ScheduleEntity(self,data)
  }


  _scheduled_episode?: ScheduledEpisodeEntity

  // Idiomatic facade: `client.scheduled_episode.list()` / `client.scheduled_episode.load({ id })`.
  get scheduled_episode(): ScheduledEpisodeEntity {
    return (this._scheduled_episode ??= new ScheduledEpisodeEntity(this, undefined))
  }

  /** @deprecated Use `client.scheduled_episode` instead. */
  ScheduledEpisode(data?: any) {
    const self = this
    return new ScheduledEpisodeEntity(self,data)
  }


  _search?: SearchEntity

  // Idiomatic facade: `client.search.list()` / `client.search.load({ id })`.
  get search(): SearchEntity {
    return (this._search ??= new SearchEntity(this, undefined))
  }

  /** @deprecated Use `client.search` instead. */
  Search(data?: any) {
    const self = this
    return new SearchEntity(self,data)
  }


  _season?: SeasonEntity

  // Idiomatic facade: `client.season.list()` / `client.season.load({ id })`.
  get season(): SeasonEntity {
    return (this._season ??= new SeasonEntity(this, undefined))
  }

  /** @deprecated Use `client.season` instead. */
  Season(data?: any) {
    const self = this
    return new SeasonEntity(self,data)
  }


  _show?: ShowEntity

  // Idiomatic facade: `client.show.list()` / `client.show.load({ id })`.
  get show(): ShowEntity {
    return (this._show ??= new ShowEntity(this, undefined))
  }

  /** @deprecated Use `client.show` instead. */
  Show(data?: any) {
    const self = this
    return new ShowEntity(self,data)
  }


  _update?: UpdateEntity

  // Idiomatic facade: `client.update.list()` / `client.update.load({ id })`.
  get update(): UpdateEntity {
    return (this._update ??= new UpdateEntity(this, undefined))
  }

  /** @deprecated Use `client.update` instead. */
  Update(data?: any) {
    const self = this
    return new UpdateEntity(self,data)
  }




  static test(testoptsarg?: any, sdkoptsarg?: any) {
    const struct = stdutil.struct
    const setpath = struct.setpath
    const getdef = struct.getdef
    const clone = struct.clone
    const setprop = struct.setprop

    const sdkopts = getdef(clone(sdkoptsarg), {})
    const testopts = getdef(clone(testoptsarg), {})
    setprop(testopts, 'active', true)
    setpath(sdkopts, 'feature.test', testopts)

    const testsdk = new TvmazeSDK(sdkopts)
    testsdk._mode = 'test'

    return testsdk
  }


  tester(testopts?: any, sdkopts?: any) {
    return TvmazeSDK.test(testopts, sdkopts)
  }


  toJSON() {
    return { name: 'Tvmaze' }
  }

  toString() {
    return 'Tvmaze ' + this._utility.struct.jsonify(this.toJSON())
  }

  [inspect.custom]() {
    return this.toString()
  }

}




const SDK = TvmazeSDK


export {
  stdutil,

  BaseFeature,
  TvmazeEntityBase,

  TvmazeSDK,
  SDK,
}


