numberProto = Number.prototype

{defineProperty} = Object
unless defineProperty?
  defineProperty = (object, name, descriptor) ->
    object.__defineGetter__ name, descriptor.get

addGetter = (name, fn) ->
  get = if name is 'random' then -> this * fn() else -> fn this
  defineProperty numberProto, name, {get}

addSCMethod = (name, fn) ->
  Number::[name] = fn

scgetters = {
  real: (me) -> me
  imag: -> 0
  reciprocal: (me) -> 1/me
}

for name, fn of scgetters
  addGetter name, fn 

scmethods = {
  round: (nearest=1) -> Math.round(this/nearest)*nearest
  clip: (lo, hi) -> 
    if this < lo
      lo
    else if hi < this
      hi
    else
      1*this
  exclusivelyBetween: (lo, hi) -> (lo < this) and (this < hi)
  inclusivelyBetween: (lo, hi) -> (lo <= this) and (this <= hi)
  at: (y) -> 
    try
      return new Point(1*this, y)
    catch e
      return {x: 1*this, y}
  # fuzzyEqual: (that, precision=1.0) -> Math.max(0.0, 1.0 - ((this - that).abs/precision))


}

for name, fn of scmethods
  addSCMethod name, fn

if require.main is module
  console.log 3.at(4)
  console.log 3.round(1.1), 3.round(1.1) is 3.3, 3*1.1 is 3.3
  console.log 3.round(0.96)
  console.log 3.reciprocal, 3/1.1.reciprocal, 3*1.1