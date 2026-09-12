import { TvmazeEntityBase } from '../TvmazeEntityBase';
import type { TvmazeSDK } from '../TvmazeSDK';
import type { Control } from '../types';
import type { CrewMember, CrewMemberListMatch } from '../TvmazeTypes';
declare class CrewMemberEntity extends TvmazeEntityBase<CrewMember> {
    constructor(client: TvmazeSDK, entopts: any);
    make(this: CrewMemberEntity): CrewMemberEntity;
    list(this: any, reqmatch?: CrewMemberListMatch, ctrl?: Control): Promise<CrewMemberEntity[]>;
}
export { CrewMemberEntity };
