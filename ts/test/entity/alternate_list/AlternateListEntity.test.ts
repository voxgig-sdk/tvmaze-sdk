
const envlocal = __dirname + '/../../../.env.local'
require('dotenv').config({ quiet: true, path: [envlocal] })

import Path from 'node:path'
import * as Fs from 'node:fs'

import { test, describe, afterEach } from 'node:test'
import assert from 'node:assert'


import { TvmazeSDK, BaseFeature, stdutil } from '../../..'

import {
  envOverride,
  liveDelay,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
  maybeSkipControl,
} from '../../utility'


describe('AlternateListEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when TVMAZE_TEST_LIVE=TRUE.
  afterEach(liveDelay('TVMAZE_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = TvmazeSDK.test()
    const ent = testsdk.AlternateList()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.TVMAZE_TEST_LIVE
    for (const op of ['list', 'load']) {
      if (maybeSkipControl(t, 'entityOp', 'alternate_list.' + op, live)) return
    }

    const setup = basicSetup()
    // The basic flow consumes synthetic IDs and field values from the
    // fixture (entity TestData.json). Those don't exist on the live API.
    // Skip live runs unless the user provided a real ENTID env override.
    if (setup.syntheticOnly) {
      t.skip('live entity test uses synthetic IDs from fixture — set TVMAZE_TEST_ALTERNATE_LIST_ENTID JSON to run live')
      return
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select

    let alternate_list_ref01_data = Object.values(setup.data.existing.alternate_list)[0] as any

    // LIST
    const alternate_list_ref01_ent = client.AlternateList()
    const alternate_list_ref01_match: any = {}
    alternate_list_ref01_match['show_id'] = setup.idmap['show01']

    const alternate_list_ref01_list = await alternate_list_ref01_ent.list(alternate_list_ref01_match)


    // LOAD
    const alternate_list_ref01_match_dt0: any = {}
    alternate_list_ref01_match_dt0.id = alternate_list_ref01_data.id
    const alternate_list_ref01_data_dt0 = await alternate_list_ref01_ent.load(alternate_list_ref01_match_dt0)
    assert(alternate_list_ref01_data_dt0.id === alternate_list_ref01_data.id)


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/alternate_list/AlternateListTestData.json')

  // TODO: file ready util needed?
  const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8')

  // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
  const entityData = JSON.parse(entityDataSource)

  options.entity = entityData.existing

  let client = TvmazeSDK.test(options, extra)
  const struct = client.utility().struct
  const merge = struct.merge
  const transform = struct.transform

  let idmap = transform(
    ['alternate_list01','alternate_list02','alternate_list03','show01','show02','show03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  // Detect whether the user provided a real ENTID JSON via env var. The
  // basic flow consumes synthetic IDs from the fixture file; without an
  // override those synthetic IDs reach the live API and 4xx. Surface this
  // to the test so it can skip rather than fail.
  const idmapEnvVal = process.env['TVMAZE_TEST_ALTERNATE_LIST_ENTID']
  const idmapOverridden = null != idmapEnvVal && idmapEnvVal.trim().startsWith('{')

  const env = envOverride({
    'TVMAZE_TEST_ALTERNATE_LIST_ENTID': idmap,
    'TVMAZE_TEST_LIVE': 'FALSE',
    'TVMAZE_TEST_EXPLAIN': 'FALSE',
  })

  idmap = env['TVMAZE_TEST_ALTERNATE_LIST_ENTID']

  const live = 'TRUE' === env.TVMAZE_TEST_LIVE

  if (live) {
    client = new TvmazeSDK(merge([
      {
      },
      extra
    ]))
  }

  const setup = {
    idmap,
    env,
    options,
    client,
    struct,
    data: entityData,
    explain: 'TRUE' === env.TVMAZE_TEST_EXPLAIN,
    live,
    syntheticOnly: live && !idmapOverridden,
    now: Date.now(),
  }

  return setup
}
  
