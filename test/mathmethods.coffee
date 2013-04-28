{Assertion} = require 'should'

require '../src/mathmethods'


Object.defineProperty Assertion.prototype, 'NaN'
  get: ->
    @assert @obj isnt @obj,
      -> "expected #{@inspect} to be NaN"
      -> "expected #{@inspect} not to be NaN"
    this


describe 'mathmethods', ->

  it 'adds "abs" property to Number.prototype', ->
    10.abs.should.equal 10
    10.5.abs.should.equal 10.5
    (-10).abs.should.equal 10
    (-10.abs).should.equal -10 # don't do this!

  it 'adds "acos" property to Number.prototype', ->
    (-1).acos.should.equal Math.PI
    1.acos.should.equal 0
    2.acos.should.be.NaN

  it 'adds "asin" property to Number.prototype', ->
    (-1).asin.should.equal -Math.PI / 2
    1.asin.should.equal Math.PI / 2
    2.asin.should.be.NaN

  it 'adds "atan" property to Number.prototype', ->
    (-1).atan.should.equal Math.atan -1
    0.atan.should.equal 0
    10.atan.should.equal Math.atan 10

  it 'adds "atan2" method to Number.prototype', ->
    0.atan2(0).should.equal 0
    Infinity.atan2(0).should.equal Math.PI / 2
    Infinity.atan2(Infinity).should.equal Math.PI / 4

  it 'adds "ceil" property to Number.prototype', ->
    Math.PI.ceil.should.equal 4
    (3 * 0.4).ceil.should.equal 2
    (-6.9.ceil).should.equal -7 # don't do this!
    (-6.9).ceil.should.equal -6 # don't do this!

  it 'adds "cos" property to Number.prototype', ->
    (2 * Math.PI).cos.should.equal 1
    Math.PI.cos.should.equal -1

  it 'adds "exp" property to Number.prototype', ->
    1.exp.should.equal Math.E
    7.2.exp.should.equal Math.exp 7.2

  it 'adds "floor" property to Number.prototype', ->
    Math.PI.floor.should.equal 3
    (-4.1).floor.should.equal -5
    (-4.1.floor).should.equal -4 # don't do this!
    (-4.1).floor.should.equal -5 # don't do this!

  it 'adds "log" property to Number.prototype', ->
    10.log.should.equal Math.log 10
    0.log.should.equal -Infinity
    (-1).log.should.be.NaN

  it 'adds "log2" property to Number.prototype', ->
    2.log2.should.equal 1
    4.log2.should.equal 2
    0.log2.should.equal -Infinity
    (-1).log2.should.be.NaN

  it 'adds "log10" property to Number.prototype', ->
    10.log10.should.equal 1
    100.log10.should.equal 2
    0.log10.should.equal -Infinity
    (-1).log10.should.be.NaN

  it 'adds "max" method to Number.prototype', ->
    0.max(3, -5, 4, -1).should.equal 4
    (-3.6).max().should.equal -3.6
    (-10).max(null).should.equal 0
    0.max('foo').should.be.NaN

  it 'adds "min" method to Number.prototype', ->
    0.min(3, -5, 4, -1).should.equal -5
    (-3.6).min().should.equal -3.6
    (-10).min(null).should.equal -10
    0.min('foo').should.be.NaN

  it 'adds "pow" method to Number.prototype', ->
    3.pow(4).should.equal 81
    1.5.pow(3).should.equal 3.375
    Infinity.pow(0).should.equal 1
    1.pow(Infinity).should.be.NaN

  it 'adds "random" property to Number.prototype', ->
    0.random.should.equal 0
    100.random.should.be.below 100
    (-5).random.should.not.be.above 0

  it 'adds "round" property to Number.prototype', ->
    20.49.round().should.equal 20
    20.5.round().should.equal 21
    (-20.5).round().should.equal -20
    (-20.51).round().should.equal -21
    20.49.round(0.1).should.equal 20.5
    20.5.round(15).should.equal 15
    (-20.5).round(2).should.equal -20
    (-20.511).round(0.01).should.equal -20.51

  it 'adds "sin" property to Number.prototype', ->
    (Math.PI / 2).sin.should.equal 1
    (-100).sin.should.equal Math.sin -100
    Infinity.sin.should.be.NaN

  it 'adds "sqrt" property to Number.prototype', ->
    9.sqrt.should.equal 3
    Infinity.sqrt.should.equal Infinity
    (-10).sqrt.should.be.NaN

  it 'adds "tan" property to Number.prototype', ->
    0.tan.should.equal 0
    100.tan.should.equal Math.tan 100
    (-Infinity).tan.should.be.NaN

  it 'adds "squared" property to Number.prototype', ->
    8.squared.should.equal 64
    1.5.squared.should.equal 2.25
    (-7).squared.should.equal 49

  it 'adds "cubed" property to Number.prototype', ->
    3.cubed.should.equal 27
    (-1.5).cubed.should.equal -3.375

  it 'adds "fact" property to Number.prototype', ->
    0.fact.should.equal 1
    1.fact.should.equal 1
    5.fact.should.equal 120
    (try (-1).fact catch err then err).should.be.an.instanceof RangeError
    (try 3.75.fact catch err then err).should.be.an.instanceof TypeError

  it 'adds "degrad" property to Number.prototype', ->
    270.degrad.should.equal 1.5.pi
    90.degrad.should.equal 0.5.pi
    (-90).degrad.should.equal -0.5.pi

  it 'adds "raddeg" property to Number.prototype', ->
    2.pi.raddeg.should.equal 360
    1.pi.raddeg.should.equal 180
    0.raddeg.should.equal 0
    (-0.5).pi.raddeg.should.equal -90

  it 'adds "hypot" method to Number.prototype', ->
    3.hypot(4).should.equal 5
    3.hypot(-4).should.equal 5
    (-3).hypot(4).should.equal 5
    (-3).hypot(0).should.equal 3
    (0).hypot(6).should.equal 6

  it 'adds "sign" property to Number.prototype', ->
    3.sign.should.equal 1
    (-3).sign.should.equal -1
    (0).sign.should.equal 0
    (+0).sign.should.equal 0
    (-0).sign.should.equal 0
    Infinity.sign.should.equal 1
    (-Infinity).sign.should.equal -1

  it 'adds "reciprocal" property to Number.prototype', ->
    3.reciprocal.should.equal 1/3
    (-3).reciprocal.should.equal -1/3
    (0).reciprocal.should.equal Infinity
    0.25.reciprocal.should.equal 4
    0.reciprocal.should.be.Infinity

  it 'adds "clip" method to Number.prototype', ->
    3.clip(1,4).should.equal 3
    3.clip(3,4).should.equal 3
    3.clip(1,2).should.equal 2
    3.clip(4, 10).should.equal 4
    0.1.clip(0, 0.1).should.equal 0.1

  it 'adds "exclusivelyBetween" method to Number.prototype', ->
    3.exclusivelyBetween(1,4).should.equal yes
    3.exclusivelyBetween(3,4).should.equal no
    3.exclusivelyBetween(1,2).should.equal no
    3.exclusivelyBetween(4, 10).should.equal no
    0.1.exclusivelyBetween(0, 0.1).should.equal no

  it 'adds "inclusivelyBetween" method to Number.prototype', ->
    3.inclusivelyBetween(1,4).should.equal yes
    3.inclusivelyBetween(3,4).should.equal yes
    3.inclusivelyBetween(1,2).should.equal no
    3.inclusivelyBetween(4, 10).should.equal no
    0.1.inclusivelyBetween(0, 0.1).should.equal yes

  it 'adds "nextPowerOf" method to Number.prototype', ->
    3.nextPowerOf(1).should.equal 1
    3.nextPowerOf(3).should.equal 3
    4.nextPowerOf(3).should.equal 9
    3.nextPowerOf(2).should.equal 4
    (-3).nextPowerOf(2).should.be.NaN
    0.1.nextPowerOf(2).should.equal 1/8

  it 'adds "previousPowerOf" method to Number.prototype', ->
    3.previousPowerOf(1).should.equal 1
    3.previousPowerOf(3).should.equal 1
    4.previousPowerOf(3).should.equal 3
    3.previousPowerOf(2).should.equal 2
    (-3).previousPowerOf(2).should.be.NaN
    0.1.previousPowerOf(2).should.equal 1/16

  it 'adds "absdif" method to Number.prototype', ->
    3.absdif(1).should.equal 2
    3.absdif(3).should.equal 0
    4.absdif(3).should.equal 1
    3.absdif(2).should.equal 1
    (-3).absdif(2).should.equal 5
    0.1.absdif(2).should.equal 1.9

  it 'adds "fuzzyEqual" method to Number.prototype', ->
    3.fuzzyEqual(3.1, 0.01).should.equal 0
    3.fuzzyEqual(3.1, 0.1).should.equal 0
    3.fuzzyEqual(3.1, 0.2).should.be.greaterThan 0
    (7*0.2).fuzzyEqual(1.4, 0.0001).should.be.greaterThan 0

  it 'adds "frac" property to Number.prototype', ->
    3.frac.should.equal 0
    3.1.frac.fuzzyEqual(0.1).should.be.greaterThan 0
    0.02.frac.should.equal 0.02
    (-1).frac.should.equal 0
    (-1.3).frac.fuzzyEqual(-0.3).should.be.greaterThan 0

  it 'adds "linlin" method to Number.prototype', ->
    0.linlin(0, 10, 100, 150).should.equal 100
    1.linlin(0, 10, 100, 150).should.equal 105
    0.2.linlin(0, 1, 100, 150).should.equal 110
    1.2.linlin(0, 1, 100, 150).should.equal 150
    1.2.linlin(0, 1, 100, 150, 'min').should.equal 160
    (-1).linlin(0, 1, 100, 150).should.equal 100
    (-1).linlin(0, 1, 100, 150, 'max').should.equal 50

  it 'adds "linexp" method to Number.prototype', ->
    0.linexp(0, 1, 100, 200).should.equal 100
    1.linexp(0, 1, 100, 200).should.equal 200
    0.2.linexp(0, 1, 100, 200).fuzzyEqual(114.8698354997, 0.0000001).should.be.greaterThan 0 
    1.2.linexp(0, 1, 100, 200).should.equal 200
    1.2.linexp(0, 1, 100, 200, 'min').fuzzyEqual(229.73967099941, 0.0000001).should.be.greaterThan 0  
    (-0.5).linexp(0, 1, 100, 200).should.equal 100
    (-0.5).linexp(0, 1, 100, 200, 'max').fuzzyEqual(70.710678118655, 0.0000001).should.be.greaterThan 0

  it 'adds "explin" method to Number.prototype', ->
    0.explin(0, 1, 100, 200).should.equal 100
    1.explin(0, 1, 100, 200).should.equal 200
    1.5.explin(1, 2, 100, 200).fuzzyEqual(158.49625007212, 0.0000001).should.be.greaterThan 0 
    1.2.explin(1, 2, 100, 200).fuzzyEqual(126.30344058338, 0.0000001).should.be.greaterThan 0 
    2.8.explin(1, 2, 100, 200, 'min').fuzzyEqual(248.54268271702, 0.0000001).should.be.greaterThan 0  
    0.9.explin(1, 2, 100, 200, 'max').fuzzyEqual(84.799690655495, 0.0000001).should.be.greaterThan 0  
    (-0.5).explin(1, 2, 100, 200).should.equal 100
    (-0.5).explin(1, 2, 100, 200, 'max').should.be.NaN

  it 'adds "expexp" method to Number.prototype', ->
    0.expexp(0, 1, 100, 200).should.equal 100
    1.expexp(0, 1, 100, 200).should.equal 200
    1.5.expexp(1, 2, 100, 200).fuzzyEqual(150, 0.0000001).should.be.greaterThan 0 
    1.2.expexp(1, 2, 100, 200).fuzzyEqual(120, 0.0000001).should.be.greaterThan 0 
    2.8.expexp(1, 2, 100, 200, 'min').fuzzyEqual(280, 0.0000001).should.be.greaterThan 0  
    0.9.expexp(1, 2, 100, 200, 'max').fuzzyEqual(90, 0.0000001).should.be.greaterThan 0  
    (-0.5).expexp(1, 2, 100, 200).should.equal 100
    (-0.5).expexp(1, 2, 100, 200, 'max').should.be.NaN

  it 'adds "lincurve" and "curvelin" methods to Number.prototype', ->
    curve = [
      0
      0.33583091167019
      0.56094510384114
      0.71184365950044
      0.8129939862767
      0.88079707797788
      0.92624684952838
      0.95671274248641
      0.97713464125656
      0.9908238493803
      1
    ]
    for i in [0..10]
      (i/10).lincurve().fuzzyEqual(curve[i]).should.be.greaterThan 0
      (curve[i]).curvelin().fuzzyEqual(i/10).should.be.greaterThan 0

  it 'adds "pi" property to Number.prototype', ->
    {PI} = Math
    0.pi.should.equal 0*PI
    2.pi.should.equal 2*PI
    0.5.pi.should.equal 0.5*PI
    (-0.1).pi.should.equal (-0.1)*PI
