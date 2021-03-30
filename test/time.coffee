import assert from "assert"
import {test, print} from "amen"

import {
  sleep
  timer
  # benchmark
} from "../src/time"

do ->

  print await test "time helpers", [

    test "timer"

    test "sleep"

    test "benchmark"
 ]
