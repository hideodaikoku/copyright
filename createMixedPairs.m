function mixed_stimuli_pairs = createMixedPairs(songstr)

x = 1:length(songstr);
odv = x(rem(x,2)==1)';
evv = x(rem(x,2)==0)';

while 1
   odv_shuffle = odv(randperm(length(odv)));
   evv_shuffle = evv(randperm(length(evv)));

   row_diff = evv_shuffle - odv_shuffle;

   if find(row_diff==1) > 0
      continue;
   else
      stimuli_pairs = [odv_shuffle, evv_shuffle];
      break;
   end
end

[col, row] = size(stimuli_pairs);
mixed_stimuli_pairs = cell(col,row);
for i = 1:col
   for k = 1:row
      mixed_stimuli_pairs{i,k} = songstr{stimuli_pairs(i,k)};
   end
end


