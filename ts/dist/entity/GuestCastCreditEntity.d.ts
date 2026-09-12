import { TvmazeEntityBase } from '../TvmazeEntityBase';
import type { TvmazeSDK } from '../TvmazeSDK';
import type { Control } from '../types';
import type { GuestCastCredit, GuestCastCreditListMatch } from '../TvmazeTypes';
declare class GuestCastCreditEntity extends TvmazeEntityBase<GuestCastCredit> {
    constructor(client: TvmazeSDK, entopts: any);
    make(this: GuestCastCreditEntity): GuestCastCreditEntity;
    list(this: any, reqmatch?: GuestCastCreditListMatch, ctrl?: Control): Promise<GuestCastCreditEntity[]>;
}
export { GuestCastCreditEntity };
