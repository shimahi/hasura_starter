import { css } from '@emotion/core'

export const xxs = `@media (max-width: 413.98px)`
export const xs = `@media (max-width: 575.98px)`
export const sm = `@media (min-width: 575.98px)`
export const md = `@media (min-width: 767.98px)`
export const lg = `@media (min-width: 991.98px)`
export const xl = `@media (min-width: 1199.98px)`
export const xxl = `@media (min-width: 1599.98px)`

export const fixAspectRatio = (x: number, y: number) => css`
  &:before {
    content: '';
    display: block;
    padding-top: calc((${x} / ${y} * 100%));
  }
`
