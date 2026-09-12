import { TvmazeEntityBase } from '../TvmazeEntityBase';
import type { TvmazeSDK } from '../TvmazeSDK';
import type { Control } from '../types';
import type { Show, ShowLoadMatch, ShowListMatch } from '../TvmazeTypes';
declare class ShowEntity extends TvmazeEntityBase<Show> {
    constructor(client: TvmazeSDK, entopts: any);
    make(this: ShowEntity): ShowEntity;
    load(this: any, reqmatch?: ShowLoadMatch, ctrl?: Control): Promise<ShowEntity>;
    list(this: any, reqmatch?: ShowListMatch, ctrl?: Control): Promise<ShowEntity[]>;
}
export { ShowEntity };
