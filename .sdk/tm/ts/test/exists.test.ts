
import { test, describe } from 'node:test'
import { equal } from 'node:assert'


import { TvmazeSDK } from '..'


describe('exists', async () => {

  test('test-mode', async () => {
    const testsdk = await TvmazeSDK.test()
    equal(null !== testsdk, true)
  })

})
