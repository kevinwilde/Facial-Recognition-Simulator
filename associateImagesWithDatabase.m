function minErrorPos = associateImagesWithDatabase(images, correctDatabase)

minErrorPos = zeros(1,size(images,2));
for jj = 1:size(images,2)
   minErrorPos(jj)=findMinimumErrorPosition(images(:,jj), correctDatabase);
end

end

