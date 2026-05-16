
import { Context } from './Context'


class TvmazeError extends Error {

  isTvmazeError = true

  sdk = 'Tvmaze'

  code: string
  ctx: Context

  constructor(code: string, msg: string, ctx: Context) {
    super(msg)
    this.code = code
    this.ctx = ctx
  }

}

export {
  TvmazeError
}

