import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'

const candleStickApiHeaders = {
    'X-RapidAPI-Key': '4f3e78da7bmshe42ed83ee88f166p11d165jsnba2dc60f2938',
    'X-RapidAPI-Host': 'candlestick-chart.p.rapidapi.com'
}

const baseUrl = 'https://candlestick-chart.p.rapidapi.com/binance';

const createRequest = (url) => ({ url, headers: candleStickApiHeaders })

export const candleStickApi = createApi({
    reducerPath: 'candleStickApi',
    baseQuery: fetchBaseQuery({ baseUrl }),
    endpoints: (builder) => ({
        getCandleStick: builder.query({
            query: (count) => createRequest(`/coins?limit=${count}`)
        }),


    })
})

export const {
    useGetCandleStickQuery,
} = candleStickApi;
