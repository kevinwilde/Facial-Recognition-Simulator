function plotIndices(scrambledIndices, correctIndices)

figure();

subplot(1,2,1), plot(1:size(scrambledIndices,2), scrambledIndices, 'bo');
axis('square');
axis([0 size(scrambledIndices,2) 0 size(scrambledIndices,2)]);
title('Scrambled Indices');
xlabel('Student ID');
ylabel('Database Column');


subplot(1,2,2), plot(1:size(correctIndices,2), correctIndices, 'bo');
axis('square');
axis([0 size(correctIndices,2) 0 size(correctIndices,2)]);
title('Correct Indices');
xlabel('Student ID');
ylabel('Database Column');

end

