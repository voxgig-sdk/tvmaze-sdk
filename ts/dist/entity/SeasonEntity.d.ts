import { TvmazeEntityBase } from '../TvmazeEntityBase';
import type { TvmazeSDK } from '../TvmazeSDK';
import type { Control } from '../types';
import type { Season, SeasonListMatch } from '../TvmazeTypes';
declare class SeasonEntity extends TvmazeEntityBase<Season> {
    constructor(client: TvmazeSDK, entopts: any);
    make(this: SeasonEntity): SeasonEntity;
    list(this: any, reqmatch?: SeasonListMatch, ctrl?: Control): Promise<SeasonEntity[]>;
}
export { SeasonEntity };
