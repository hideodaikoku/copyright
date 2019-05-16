function full_stimuli_pairs = createOrderedPairs(songstr)

x = 1:length(songstr);
odv = x(rem(x,2)==1)';
evv = x(rem(x,2)==0)';

stimuli_pairs = [odv, evv];
[col, row] = size(stimuli_pairs);
full_stimuli_pairs = cell(col,row);
for i = 1:col
   for k = 1:row
      full_stimuli_pairs{i,k} = songstr{stimuli_pairs(i,k)};
   end
end