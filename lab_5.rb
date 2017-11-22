def pow_m(modul, exp, power)
  p = nil
  rx = 1

  return 0 if modul == 0

  p[0] = exp % modul

  1..32.each do |i|
    rx = p[i-1]
    rx = (rx*p[i-1]) % modul
    p[i] = rx
  end

  rx = 1

  0..32.each do |i|
    rx = (rx * p[i]) % modul if power & test
  end

  rx
end

