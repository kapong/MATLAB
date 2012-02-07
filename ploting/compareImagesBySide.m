function imOut=compareImagesBySide(imIn,showlines,shownumbers,frac)
% Compares images by putting parts of the imags side by side. 
% imOut=compareImagesBySide(imIn,showlines,shownumbers,frac)
% imIn - stack of images to be compared
% showlines - if true (default) then line is drawn to separate individual sections.
% shownumbers - if true (default) then number to individual section is
% displayed.
% frac - vector specifying fractions of the individual sections (default: frac=size(Im(1))/numberOfImages

if ~exist('showlines','var')
    showlines = 1; 
end

if ~exist('shownumbers','var')
    shownumbers = 1;
end

sizeIm=size(imIn); 
numberOfImages=sizeIm(3); 
if ~exist('frac','var')
    frac=repmat(floor(sizeIm(1)/numberOfImages),1,size(imIn,3));
end


imOut = imIn(0:frac(1)-1,:,0);
for ii=1:numberOfImages-1
    startInd=frac(ii);
    endInd=sum(frac(1:ii+1))-1;     
    imOut = cat(1,imOut,imIn(startInd:endInd,:,ii));    
end

colorvalue = 'w';

if showlines
dipshow(double(imOut))
for ii=1:numberOfImages-1
    startInd=(ii)*frac(ii)-1;
    line([startInd,startInd],[0,sizeIm(2)],'color',colorvalue,'linewidth',1)
end
end

if shownumbers
for ii=1:numberOfImages
    startInd=(ii)*frac(ii)-1-0.5*frac(ii);
    text(startInd,sizeIm(2)/10,num2str(ii),'color',colorvalue,'fontsize',20)    
end
end
