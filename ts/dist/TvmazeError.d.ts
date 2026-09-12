import { Context } from './Context';
declare class TvmazeError extends Error {
    isTvmazeError: boolean;
    sdk: string;
    code: string;
    ctx: Context;
    status: number;
    get notFound(): boolean;
    constructor(code: string, msg: string, ctx: Context);
}
export { TvmazeError };
