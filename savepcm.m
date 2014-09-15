%% Copyright (C) 2005 Denis Sbragion
%%
%% This program is free software; you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation; either version 2 of the License, or
%%(at your option) any later version.
%%
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License
%% along with this program; if not, write to the Free Software
%% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
%%
%% This function is part of DRC - Digital room correction

%% usage: savepcm(pcm,fname)
%%
%% savepcm: saves a pcm raw file in DRC format
%%
%% pcm = pcm raw signal
%% fname = pcm file name

function savepcm(pcm,fname);

	f = fopen(fname,"wb");
	fwrite(f,pcm,"float32");
	fclose(f);

endfunction