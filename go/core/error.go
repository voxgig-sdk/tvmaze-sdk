package core

type TvmazeError struct {
	IsTvmazeError bool
	Sdk              string
	Code             string
	Msg              string
	Ctx              *Context
	Result           any
	Spec             any
}

func NewTvmazeError(code string, msg string, ctx *Context) *TvmazeError {
	return &TvmazeError{
		IsTvmazeError: true,
		Sdk:              "Tvmaze",
		Code:             code,
		Msg:              msg,
		Ctx:              ctx,
	}
}

func (e *TvmazeError) Error() string {
	return e.Msg
}
