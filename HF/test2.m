clear all;
close all;
clc;
fid = fopen('E:\yjw_maltab_project\HF\freq.bin', 'rb');
read_data = fread(fid,'int16')';
fclose(fid);

cnt = 0;
temp3 = [];
for i = 1:length(read_data)
    if i<length(read_data)-3
        temp1 = read_data(i:i+4);
    else 
        temp1(1:length(read_data)-i+1) = read_data(i:length(read_data));
        temp1(length(read_data)-i+2:5) = read_data(1:4-length(read_data)+i);
    end
    
    count = [0 0 0 0 0];
    min = 100;
    max = 407;%153  307
    if temp1(1)<min||temp1(1)>max 
        count(1) = count(1) + 1;
    end
    if temp1(2)<min||temp1(2)>max
        count(2) = count(2) + 1;
    end
    if temp1(3)<min||temp1(3)>max
        count(3) = count(3) + 1;
    end
    if temp1(4)<min||temp1(4)>max 
        count(4) = count(4) + 1;   
    end
    if temp1(5)<min||temp1(5)>max
        count(5) = count(5) + 1;
    end
    temp2 = count(1)+count(2)+count(3)+count(4)+count(5);
%     temp3 = [temp3 temp2];
%     temp2
    if temp2 >= 4
        cnt = cnt + 1;
    end
end
cnt/length(read_data)