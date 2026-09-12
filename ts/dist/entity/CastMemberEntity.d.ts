import { TvmazeEntityBase } from '../TvmazeEntityBase';
import type { TvmazeSDK } from '../TvmazeSDK';
import type { Control } from '../types';
import type { CastMember, CastMemberListMatch } from '../TvmazeTypes';
declare class CastMemberEntity extends TvmazeEntityBase<CastMember> {
    constructor(client: TvmazeSDK, entopts: any);
    make(this: CastMemberEntity): CastMemberEntity;
    list(this: any, reqmatch?: CastMemberListMatch, ctrl?: Control): Promise<CastMemberEntity[]>;
}
export { CastMemberEntity };
