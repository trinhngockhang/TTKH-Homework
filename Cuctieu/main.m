fx = @(x) 0.1*x^3 + x^2  - 2*x;
[minX, minf] = cuc_tieu(fx, 1, 2, 0.1);

function [x1, minf] = cuc_tieu(fx, a, b, e)
  x1 = a + (b-a)/2 - e/2;
  x2 = a + (b-a)/2 + e/2;
  val1 = fx(x1);
  val2 = fx(x2);
  disp([a, b, x1, x2, val1, val2, b-a]);
  if(b - a < 2*e) 
      minf = fx(x1);
      return
  end

  if(val1 < val2)
      [x1, minf] = cuc_tieu(fx, a, x2, e);
  end
  if(val1 > val2) 
      [x1, minf] = cuc_tieu(fx, x1, b, e);
  end
  if(val1 == val2)
      [x1, minf] = cuc_tieu(fx, x1, x2, e);
  end
end


