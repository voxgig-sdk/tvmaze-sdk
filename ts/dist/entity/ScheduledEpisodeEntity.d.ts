import { TvmazeEntityBase } from '../TvmazeEntityBase';
import type { TvmazeSDK } from '../TvmazeSDK';
import type { Control } from '../types';
import type { ScheduledEpisode, ScheduledEpisodeListMatch } from '../TvmazeTypes';
declare class ScheduledEpisodeEntity extends TvmazeEntityBase<ScheduledEpisode> {
    constructor(client: TvmazeSDK, entopts: any);
    make(this: ScheduledEpisodeEntity): ScheduledEpisodeEntity;
    list(this: any, reqmatch?: ScheduledEpisodeListMatch, ctrl?: Control): Promise<ScheduledEpisodeEntity[]>;
}
export { ScheduledEpisodeEntity };
