%% usage: imp = crossLinear(fs,m,nc,fl,fh)
%%
%% Gets a windowed sinc linear phase FIR filter.
%% Window have a length in cycles at crossover frequency:
%% nc*fs/fl or nc*fs/fh.
%% The window is centered in the total length m.
%%
%% imp = FIR filter Coefficients.
%% fs  = Sampling frequency.
%% m   = Number of samples.
%% nc  = Length factor of impulse (factor of fs/fl or fs/fh).
%% fl  = Highpass crossover frequency. 0 if only lowpass.
%% fh  = Lowpass crossover frequency. 0 if only highpass.

%% This file is part of DSD
%%
%% DSD
%% A GNU-Octave set of scripts for calculating
%% digital loudspeaker crossovers and room correction filters
%% Copyright (C) 2012-2019 Roberto Ripio
%%
%% DSD is free software: you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation, either version 3 of the License, or
%% (at your option) any later version.
%%
%% DSD is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License
%% along with DSD.  If not, see <https://www.gnu.org/licenses/>.

function imp=crossLinear(fs,m,nc,fl,fh);
    
    wl=fl/fs;
    wh=fh/fs;
    
    if (fl != 0) 
        ll=nc*fs/fl;
        ll=ll+1-mod(ll,2);
        if ll >= m
            ll=m-1;
        end
        tl=(-floor(ll/2):floor(ll/2))'; % column vector
        impl=centerimp(sinc(2*wl*tl)*(2*wl).*blackmanharris(ll),m);
    end
    if (fh != 0) 
        lh=nc*fs/fh;
        lh=lh+1-mod(lh,2);
        if lh >= m
            lh=m-1;
        end
        th=(-floor(lh/2):floor(lh/2))'; % column vector
        imph=centerimp(sinc(2*wh*th)*(2*wh).*blackmanharris(lh),m);
    end
    
    
    if (fh == 0 && fl != 0) % high-pass filter
        imp=centerimp(deltacentered(ll),m)-impl;
    elseif (fh != 0 && fl == 0) % low-pass filter
        imp=imph;
    elseif (fh != 0 && fl != 0) % band-pass filter
        imp=imph-impl;
    elseif (fh == 0 && fl == 0) % no filter (delta)
        imp=centerimp(deltacentered(m-1),m);
    end;
    % imp=imp(:); %force column vector
    
end
