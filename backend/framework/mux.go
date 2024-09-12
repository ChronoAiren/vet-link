package framework

import (
	"github.com/labstack/echo/v4"
	"net/http"
)

type MethodFunc func(path string, mainFn HandlerFunc)

func (f *Framework) Mux() struct {
	Get    MethodFunc
	Post   MethodFunc
	Delete MethodFunc
	Patch  MethodFunc
} {
	return struct {
		Get    MethodFunc
		Post   MethodFunc
		Delete MethodFunc
		Patch  MethodFunc
	}{
		Get:    f.get,
		Post:   f.post,
		Delete: f.delete,
		Patch:  f.patch,
	}
}

type HandlerFunc func(c *Context, data ResultChan, err ErrorChan)
type RequestMethod func(path string, h echo.HandlerFunc, m ...echo.MiddlewareFunc) *echo.Route
type ResultChan chan<- any
type ErrorChan chan<- error

func runMethod(requestFn RequestMethod, path string, mainFn HandlerFunc) {
	requestFn(path, func(c echo.Context) error {
		dataChan := make(chan interface{})
		errChan := make(chan error)
		go func() {
			defer close(dataChan)
			defer close(errChan)
			mainFn(NewContext(c), dataChan, errChan)
		}()
		select {
		case data := <-dataChan:
			return c.JSON(http.StatusOK, data)
		case err := <-errChan:
			return echo.NewHTTPError(http.StatusBadRequest, err)
		}
	})
}

func (f *Framework) get(path string, mainFn HandlerFunc) {
	runMethod(f.Api.GET, path, mainFn)
}

func (f *Framework) post(path string, mainFn HandlerFunc) {
	runMethod(f.Api.POST, path, mainFn)
}

func (f *Framework) delete(path string, mainFn HandlerFunc) {
	runMethod(f.Api.DELETE, path, mainFn)
}

func (f *Framework) patch(path string, mainFn HandlerFunc) {
	runMethod(f.Api.PATCH, path, mainFn)
}
