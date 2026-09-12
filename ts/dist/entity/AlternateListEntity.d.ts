import { TvmazeEntityBase } from '../TvmazeEntityBase';
import type { TvmazeSDK } from '../TvmazeSDK';
import type { Control } from '../types';
import type { AlternateList, AlternateListLoadMatch, AlternateListListMatch } from '../TvmazeTypes';
declare class AlternateListEntity extends TvmazeEntityBase<AlternateList> {
    constructor(client: TvmazeSDK, entopts: any);
    make(this: AlternateListEntity): AlternateListEntity;
    load(this: any, reqmatch?: AlternateListLoadMatch, ctrl?: Control): Promise<AlternateListEntity>;
    list(this: any, reqmatch?: AlternateListListMatch, ctrl?: Control): Promise<AlternateListEntity[]>;
}
export { AlternateListEntity };
