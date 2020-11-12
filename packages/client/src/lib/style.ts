import { css } from '@emotion/react'

export const sm = `@media(min-width: 640px)`
export const md = `@media(min-width: 768px)`
export const lg = `@media(min-width: 1024px)`
export const xl = `@media(min-width: 1280px)`

export const fixAspectRatio = (x: number, y: number) => css`
  &:before {
    content: '';
    display: block;
    padding-top: calc((${x} / ${y} * 100%));
  }
`

export const limitWidthByInnerMaxWidth = (innerMaxWidth = 1280) => {
  const innerMaxPx = `${innerMaxWidth}px`

  return css`
    @media (max-width: ${innerMaxPx}) {
      padding-left: calc((100vw - ${innerMaxPx}) / 2);
      padding-right: calc((100vw - ${innerMaxPx}) / 2);
    }
  `
}

export const convertTrackingToEm = (tracking: number) => {
  return `${tracking / 1000}em`
}

export const applyChildGridArea = (count: number) => {
  const array = [...Array(count)].map((_, i) => i + 1)

  return array.map((n) => {
    const area = `area_${n}`

    return css`
      & > *:nth-of-type(${String(n)}) {
        grid-area: ${area};
      }
    `
  })
}
