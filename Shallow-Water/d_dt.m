function [dh, du, dv] = d_dt(fh,fu,fv,g,dx,dy)
    du = - g*d_dx(fh,dx);
    dv = - g*d_dy(fh,dy);
    dh = - d_dx(fu.*fh,dx) - d_dy(fv.*fh,dy);
end
