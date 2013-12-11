
{defineProperty} = Object
unless defineProperty?
  defineProperty = (object, name, descriptor) ->
    if descriptor.get?
      object.__defineGetter__ name, descriptor.get
    else if descriptor.value?
      object[name] = descriptor.value

{abs, acos, asin, atan, ceil, cos, exp, floor, log, round, sin, sqrt, tan, atan2, max, min, pow} = Math

log2 = log 2
log10 = log 10
pi = Math.PI

degradConstant = pi/180
raddegConstant = 180/pi

roundTo = (me, nearest=1) -> round(me/nearest)*nearest
module.exports = {
  abs, acos, asin, atan, ceil, cos, exp, floor, log, sin, sqrt, tan, atan2, max, min, pow

  random: (me) -> me * Math.random()

  log2: (me) -> log(me) / log2 
  log10: (me) -> log(me) / log10
  degrad: (me) -> me*degradConstant
  raddeg: (me) -> me*raddegConstant
  pi: (me) -> me*pi
  reciprocal: (me) -> 1/me
  squared: (me) -> me * me
  cubed: (me) -> me * me * me
  sign: (me) -> 
    switch 
      when me > 0 then 1
      when me < 0 then -1
      else 0
  fact: (me) ->
    n = +me
    throw new RangeError "#{n} is not positive" if n < 0
    throw new TypeError "#{n} is not an integer" unless n is (n | 0)
    product = 1
    product *= n-- while n
    product

  roundTo: roundTo
  round: roundTo

  hypot: (a, b) -> 
    #(a*a + b*b).sqrt
    if a is 0
      abs b
    else
      abs(a) * sqrt(1 + pow(b/a, 2))

  div: (me, denominator) -> (me/denominator) | 0 # integer division

  clip: (me, lo, hi) -> 
    switch
      when me < lo then lo
      when hi < me then hi
      else +me

  exclusivelyBetween: (me, lo, hi) -> (lo < me) and (me < hi)
  inclusivelyBetween: (me, lo, hi) -> (lo <= me) and (me <= hi)

  nextPowerOf: (me, base) -> 
    return 1 if base is 1
    pow( base, ceil(log(me) / log(base)) ) 
    
  previousPowerOf: (me, base) -> 
    return 1 if base is 1
    pow( base, ceil(log(me) / log(base)) - 1 ) 

  absdif: (me, that) -> (me - that).abs
  
  fuzzyEqual: (me, that, precision=0.001) -> (1.0 - abs(me - that)/precision).max(0) # return 0 or 1-absdif

  frac: (me) -> me - (me | 0)

  factors: (me) ->
    n_factors = []
    i = 1
    while i <= Math.floor(Math.sqrt(me))
      if me % i is 0
        n_factors.push i
        n_factors.push( me / i )  unless me / i is i
      i++
    n_factors.sort (a, b) -> # numeric sort
      a - b
    n_factors

  linlin: (me, inMin, inMax, outMin, outMax, clip='minmax') ->
    # linear to linear mapping
    mapClip(me, inMin, inMax, outMin, outMax, clip) ?
    (me-inMin)/(inMax-inMin) * (outMax-outMin) + outMin

  linexp: (me, inMin, inMax, outMin, outMax, clip='minmax') ->
    # linear to exponential mapping
    mapClip(me, inMin, inMax, outMin, outMax, clip) ?
    pow(outMax/outMin, (me-inMin)/(inMax-inMin)) * outMin

  explin: (me, inMin, inMax, outMin, outMax, clip='minmax') ->
    # linear to exponential mapping
    mapClip(me, inMin, inMax, outMin, outMax, clip) ?
    log(me/inMin) / log(inMax/inMin) * (outMax-outMin) + outMin

  expexp: (me, inMin, inMax, outMin, outMax, clip='minmax') ->
    # linear to exponential mapping
    mapClip(me, inMin, inMax, outMin, outMax, clip) ?
    pow(outMax/outMin, log(me/inMin) / log(inMax/inMin)) * outMin

  lincurve: (me, inMin = 0, inMax = 1, outMin = 0, outMax = 1, curve = -4, clip='minmax') ->
    # linear to curve mapping
    clip = mapClip(me, inMin, inMax, outMin, outMax, clip)
    return clip if clip?
    me.linlin(inMin, inMax, outMin, outMax) if (abs(curve) < 0.001)

    grow = exp(curve)
    a = (outMax - outMin) / (1 - grow)
    b = outMin + a
    scaled = (me - inMin) / (inMax - inMin)
    b - (a * pow(grow, scaled))

  curvelin: (me, inMin = 0, inMax = 1, outMin = 0, outMax = 1, curve = -4, clip='minmax') ->
    # curve to linear mapping
    clip = mapClip(me, inMin, inMax, outMin, outMax, clip)
    return clip if clip?
    me.linlin(inMin, inMax, outMin, outMax) if (abs(curve) < 0.001)

    grow = exp(curve)
    a = (outMax - outMin) / (1 - grow)
    b = outMin + a
    scaled = (me - inMin) / (inMax - inMin)
    log((b - scaled) / a) / curve

}

mapClip = (me, inMin, inMax, outMin, outMax, clip) ->
  switch clip
    when 'minmax'
      return outMin if me <= inMin
      return outMax if me >= inMax
    when 'min'
      return outMin if me <= inMin
    when 'max'
      return outMax if me >= inMax
  return null

for name, fn of module.exports
  do(fn) ->
    descriptor = { enumerable: no }
    if fn.length is 1
      descriptor.get = -> fn(this) 
    else
      descriptor.value = (args...) -> fn.apply(null, [this].concat(args))
    defineProperty Number::, name, descriptor
  

if require.main is module
  console.log  ((i/10).lincurve() for i in [0..10])
  console.log  ((i/10).lincurve().curvelin() for i in [0..10])
  # console.log fns
  euc = (a,b) -> (a*a + b*b).sqrt
  for x in [1..10]
    for y in [1..10]
      throw "Err #{x}, #{y}, #{x.hypot(y)}, #{euc(x,y)}" unless abs(x.hypot(y) - euc(x, y)) < 1e-10
  console.log module.exports.hypot(1e155, 1e155+1), euc(1e155, 1e155+1), module.exports.hypot(1e155, 1e165) - euc(1e155, 1e165)


    
