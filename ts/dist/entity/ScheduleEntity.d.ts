import { TvmazeEntityBase } from '../TvmazeEntityBase';
import type { TvmazeSDK } from '../TvmazeSDK';
import type { Control } from '../types';
import type { Schedule, ScheduleListMatch } from '../TvmazeTypes';
declare class ScheduleEntity extends TvmazeEntityBase<Schedule> {
    constructor(client: TvmazeSDK, entopts: any);
    make(this: ScheduleEntity): ScheduleEntity;
    list(this: any, reqmatch?: ScheduleListMatch, ctrl?: Control): Promise<ScheduleEntity[]>;
}
export { ScheduleEntity };
