# Tvmaze SDK

from utility.voxgig_struct import voxgig_struct as vs
from core.utility_type import TvmazeUtility
from core.spec import TvmazeSpec
from core import helpers

# Load utility registration (populates Utility._registrar)
from utility import register

# Load features
from feature.base_feature import TvmazeBaseFeature
from features import _make_feature


class TvmazeSDK:

    def __init__(self, options=None):
        self.mode = "live"
        self.features = []
        self.options = None

        utility = TvmazeUtility()
        self._utility = utility

        from config import make_config
        config = make_config()

        self._rootctx = utility.make_context({
            "client": self,
            "utility": utility,
            "config": config,
            "options": options if options is not None else {},
            "shared": {},
        }, None)

        self.options = utility.make_options(self._rootctx)

        if vs.getpath(self.options, "feature.test.active") is True:
            self.mode = "test"

        self._rootctx.options = self.options

        # Add features from config.
        feature_opts = helpers.to_map(vs.getprop(self.options, "feature"))
        if feature_opts is not None:
            feature_items = vs.items(feature_opts)
            if feature_items is not None:
                for item in feature_items:
                    fname = item[0]
                    fopts = helpers.to_map(item[1])
                    if fopts is not None and fopts.get("active") is True:
                        utility.feature_add(self._rootctx, _make_feature(fname))

        # Add extension features.
        extend = vs.getprop(self.options, "extend")
        if isinstance(extend, list):
            for f in extend:
                if isinstance(f, dict) or (hasattr(f, "get_name") and callable(f.get_name)):
                    utility.feature_add(self._rootctx, f)

        # Initialize features.
        for f in self.features:
            utility.feature_init(self._rootctx, f)

        utility.feature_hook(self._rootctx, "PostConstruct")

        # #BuildFeatures

    def options_map(self):
        out = vs.clone(self.options)
        if isinstance(out, dict):
            return out
        return {}

    def get_utility(self):
        return TvmazeUtility.copy(self._utility)

    def get_root_ctx(self):
        return self._rootctx

    def prepare(self, fetchargs=None):
        utility = self._utility

        if fetchargs is None:
            fetchargs = {}

        ctrl = helpers.to_map(vs.getprop(fetchargs, "ctrl"))
        if ctrl is None:
            ctrl = {}

        ctx = utility.make_context({
            "opname": "prepare",
            "ctrl": ctrl,
        }, self._rootctx)

        options = self.options

        path = vs.getprop(fetchargs, "path") or ""
        if not isinstance(path, str):
            path = ""

        method = vs.getprop(fetchargs, "method") or "GET"
        if not isinstance(method, str):
            method = "GET"

        params = helpers.to_map(vs.getprop(fetchargs, "params"))
        if params is None:
            params = {}
        query = helpers.to_map(vs.getprop(fetchargs, "query"))
        if query is None:
            query = {}

        headers = utility.prepare_headers(ctx)

        base = vs.getprop(options, "base") or ""
        if not isinstance(base, str):
            base = ""
        prefix = vs.getprop(options, "prefix") or ""
        if not isinstance(prefix, str):
            prefix = ""
        suffix = vs.getprop(options, "suffix") or ""
        if not isinstance(suffix, str):
            suffix = ""

        ctx.spec = TvmazeSpec({
            "base": base,
            "prefix": prefix,
            "suffix": suffix,
            "path": path,
            "method": method,
            "params": params,
            "query": query,
            "headers": headers,
            "body": vs.getprop(fetchargs, "body"),
            "step": "start",
        })

        # Merge user-provided headers.
        uh = vs.getprop(fetchargs, "headers")
        if isinstance(uh, dict):
            for k, v in uh.items():
                ctx.spec.headers[k] = v

        _, err = utility.prepare_auth(ctx)
        if err is not None:
            raise err

        fetchdef, err = utility.make_fetch_def(ctx)
        if err is not None:
            raise err

        return fetchdef

    def direct(self, fetchargs=None):
        utility = self._utility

        try:
            fetchdef = self.prepare(fetchargs)
        except Exception as err:
            # direct() is the raw-HTTP escape hatch: it never raises, it
            # returns a result object callers branch on via result["ok"].
            return {"ok": False, "err": err}

        if fetchargs is None:
            fetchargs = {}
        ctrl = helpers.to_map(vs.getprop(fetchargs, "ctrl"))
        if ctrl is None:
            ctrl = {}

        ctx = utility.make_context({
            "opname": "direct",
            "ctrl": ctrl,
        }, self._rootctx)

        url = fetchdef.get("url", "")
        fetched, fetch_err = utility.fetcher(ctx, url, fetchdef)

        if fetch_err is not None:
            return {"ok": False, "err": fetch_err}

        if fetched is None:
            return {
                "ok": False,
                "err": ctx.make_error("direct_no_response", "response: undefined"),
            }

        if isinstance(fetched, dict):
            status = helpers.to_int(vs.getprop(fetched, "status"))
            headers = vs.getprop(fetched, "headers") or {}

            # No-body responses (204, 304) and explicit zero content-length
            # must skip JSON parsing — calling json() on an empty body raises.
            content_length = None
            if isinstance(headers, dict):
                content_length = headers.get("content-length")
            no_body = status in (204, 304) or str(content_length) == "0"

            json_data = None
            if not no_body:
                jf = vs.getprop(fetched, "json")
                if callable(jf):
                    try:
                        json_data = jf()
                    except Exception:
                        # Non-JSON body (e.g. text/plain, text/html). Surface
                        # status + headers but leave data as None.
                        json_data = None

            return {
                "ok": status >= 200 and status < 300,
                "status": status,
                "headers": headers,
                "data": json_data,
            }

        return {
            "ok": False,
            "err": ctx.make_error("direct_invalid", "invalid response type"),
        }


    @property
    def aka(self):
        """Idiomatic facade: client.aka.list() / client.aka.load({"id": ...})."""
        from entity.aka_entity import AkaEntity
        cached = getattr(self, "_aka", None)
        if cached is None:
            cached = AkaEntity(self, None)
            self._aka = cached
        return cached

    def Aka(self, data=None):
        # Deprecated: use client.aka instead.
        from entity.aka_entity import AkaEntity
        return AkaEntity(self, data)


    @property
    def alternate_list(self):
        """Idiomatic facade: client.alternate_list.list() / client.alternate_list.load({"id": ...})."""
        from entity.alternate_list_entity import AlternateListEntity
        cached = getattr(self, "_alternate_list", None)
        if cached is None:
            cached = AlternateListEntity(self, None)
            self._alternate_list = cached
        return cached

    def AlternateList(self, data=None):
        # Deprecated: use client.alternate_list instead.
        from entity.alternate_list_entity import AlternateListEntity
        return AlternateListEntity(self, data)


    @property
    def cast(self):
        """Idiomatic facade: client.cast.list() / client.cast.load({"id": ...})."""
        from entity.cast_entity import CastEntity
        cached = getattr(self, "_cast", None)
        if cached is None:
            cached = CastEntity(self, None)
            self._cast = cached
        return cached

    def Cast(self, data=None):
        # Deprecated: use client.cast instead.
        from entity.cast_entity import CastEntity
        return CastEntity(self, data)


    @property
    def cast_credit(self):
        """Idiomatic facade: client.cast_credit.list() / client.cast_credit.load({"id": ...})."""
        from entity.cast_credit_entity import CastCreditEntity
        cached = getattr(self, "_cast_credit", None)
        if cached is None:
            cached = CastCreditEntity(self, None)
            self._cast_credit = cached
        return cached

    def CastCredit(self, data=None):
        # Deprecated: use client.cast_credit instead.
        from entity.cast_credit_entity import CastCreditEntity
        return CastCreditEntity(self, data)


    @property
    def cast_member(self):
        """Idiomatic facade: client.cast_member.list() / client.cast_member.load({"id": ...})."""
        from entity.cast_member_entity import CastMemberEntity
        cached = getattr(self, "_cast_member", None)
        if cached is None:
            cached = CastMemberEntity(self, None)
            self._cast_member = cached
        return cached

    def CastMember(self, data=None):
        # Deprecated: use client.cast_member instead.
        from entity.cast_member_entity import CastMemberEntity
        return CastMemberEntity(self, data)


    @property
    def crew(self):
        """Idiomatic facade: client.crew.list() / client.crew.load({"id": ...})."""
        from entity.crew_entity import CrewEntity
        cached = getattr(self, "_crew", None)
        if cached is None:
            cached = CrewEntity(self, None)
            self._crew = cached
        return cached

    def Crew(self, data=None):
        # Deprecated: use client.crew instead.
        from entity.crew_entity import CrewEntity
        return CrewEntity(self, data)


    @property
    def crew_credit(self):
        """Idiomatic facade: client.crew_credit.list() / client.crew_credit.load({"id": ...})."""
        from entity.crew_credit_entity import CrewCreditEntity
        cached = getattr(self, "_crew_credit", None)
        if cached is None:
            cached = CrewCreditEntity(self, None)
            self._crew_credit = cached
        return cached

    def CrewCredit(self, data=None):
        # Deprecated: use client.crew_credit instead.
        from entity.crew_credit_entity import CrewCreditEntity
        return CrewCreditEntity(self, data)


    @property
    def crew_member(self):
        """Idiomatic facade: client.crew_member.list() / client.crew_member.load({"id": ...})."""
        from entity.crew_member_entity import CrewMemberEntity
        cached = getattr(self, "_crew_member", None)
        if cached is None:
            cached = CrewMemberEntity(self, None)
            self._crew_member = cached
        return cached

    def CrewMember(self, data=None):
        # Deprecated: use client.crew_member instead.
        from entity.crew_member_entity import CrewMemberEntity
        return CrewMemberEntity(self, data)


    @property
    def episode(self):
        """Idiomatic facade: client.episode.list() / client.episode.load({"id": ...})."""
        from entity.episode_entity import EpisodeEntity
        cached = getattr(self, "_episode", None)
        if cached is None:
            cached = EpisodeEntity(self, None)
            self._episode = cached
        return cached

    def Episode(self, data=None):
        # Deprecated: use client.episode instead.
        from entity.episode_entity import EpisodeEntity
        return EpisodeEntity(self, data)


    @property
    def guest_cast_credit(self):
        """Idiomatic facade: client.guest_cast_credit.list() / client.guest_cast_credit.load({"id": ...})."""
        from entity.guest_cast_credit_entity import GuestCastCreditEntity
        cached = getattr(self, "_guest_cast_credit", None)
        if cached is None:
            cached = GuestCastCreditEntity(self, None)
            self._guest_cast_credit = cached
        return cached

    def GuestCastCredit(self, data=None):
        # Deprecated: use client.guest_cast_credit instead.
        from entity.guest_cast_credit_entity import GuestCastCreditEntity
        return GuestCastCreditEntity(self, data)


    @property
    def image(self):
        """Idiomatic facade: client.image.list() / client.image.load({"id": ...})."""
        from entity.image_entity import ImageEntity
        cached = getattr(self, "_image", None)
        if cached is None:
            cached = ImageEntity(self, None)
            self._image = cached
        return cached

    def Image(self, data=None):
        # Deprecated: use client.image instead.
        from entity.image_entity import ImageEntity
        return ImageEntity(self, data)


    @property
    def person(self):
        """Idiomatic facade: client.person.list() / client.person.load({"id": ...})."""
        from entity.person_entity import PersonEntity
        cached = getattr(self, "_person", None)
        if cached is None:
            cached = PersonEntity(self, None)
            self._person = cached
        return cached

    def Person(self, data=None):
        # Deprecated: use client.person instead.
        from entity.person_entity import PersonEntity
        return PersonEntity(self, data)


    @property
    def schedule(self):
        """Idiomatic facade: client.schedule.list() / client.schedule.load({"id": ...})."""
        from entity.schedule_entity import ScheduleEntity
        cached = getattr(self, "_schedule", None)
        if cached is None:
            cached = ScheduleEntity(self, None)
            self._schedule = cached
        return cached

    def Schedule(self, data=None):
        # Deprecated: use client.schedule instead.
        from entity.schedule_entity import ScheduleEntity
        return ScheduleEntity(self, data)


    @property
    def scheduled_episode(self):
        """Idiomatic facade: client.scheduled_episode.list() / client.scheduled_episode.load({"id": ...})."""
        from entity.scheduled_episode_entity import ScheduledEpisodeEntity
        cached = getattr(self, "_scheduled_episode", None)
        if cached is None:
            cached = ScheduledEpisodeEntity(self, None)
            self._scheduled_episode = cached
        return cached

    def ScheduledEpisode(self, data=None):
        # Deprecated: use client.scheduled_episode instead.
        from entity.scheduled_episode_entity import ScheduledEpisodeEntity
        return ScheduledEpisodeEntity(self, data)


    @property
    def search(self):
        """Idiomatic facade: client.search.list() / client.search.load({"id": ...})."""
        from entity.search_entity import SearchEntity
        cached = getattr(self, "_search", None)
        if cached is None:
            cached = SearchEntity(self, None)
            self._search = cached
        return cached

    def Search(self, data=None):
        # Deprecated: use client.search instead.
        from entity.search_entity import SearchEntity
        return SearchEntity(self, data)


    @property
    def season(self):
        """Idiomatic facade: client.season.list() / client.season.load({"id": ...})."""
        from entity.season_entity import SeasonEntity
        cached = getattr(self, "_season", None)
        if cached is None:
            cached = SeasonEntity(self, None)
            self._season = cached
        return cached

    def Season(self, data=None):
        # Deprecated: use client.season instead.
        from entity.season_entity import SeasonEntity
        return SeasonEntity(self, data)


    @property
    def show(self):
        """Idiomatic facade: client.show.list() / client.show.load({"id": ...})."""
        from entity.show_entity import ShowEntity
        cached = getattr(self, "_show", None)
        if cached is None:
            cached = ShowEntity(self, None)
            self._show = cached
        return cached

    def Show(self, data=None):
        # Deprecated: use client.show instead.
        from entity.show_entity import ShowEntity
        return ShowEntity(self, data)


    @property
    def update(self):
        """Idiomatic facade: client.update.list() / client.update.load({"id": ...})."""
        from entity.update_entity import UpdateEntity
        cached = getattr(self, "_update", None)
        if cached is None:
            cached = UpdateEntity(self, None)
            self._update = cached
        return cached

    def Update(self, data=None):
        # Deprecated: use client.update instead.
        from entity.update_entity import UpdateEntity
        return UpdateEntity(self, data)



    @classmethod
    def test(cls, testopts=None, sdkopts=None):
        if sdkopts is None:
            sdkopts = {}
        sdkopts = vs.clone(sdkopts)
        if not isinstance(sdkopts, dict):
            sdkopts = {}

        if testopts is None:
            testopts = {}
        testopts = vs.clone(testopts)
        if not isinstance(testopts, dict):
            testopts = {}
        testopts["active"] = True

        vs.setpath(sdkopts, "feature.test", testopts)

        sdk = cls(sdkopts)
        sdk.mode = "test"

        return sdk
