function [ MRF_res ] = shs2016f_adapt_thre( prev_f,next_f,last_state,Sig ,T)
%SHS2016F_FIRST_MAR_THRE Summary of this function goes here
%   Detailed explanation goes here

theta=1;
MrS=5;
[H,W] = size(prev_f);

MRF_res = zeros(H,W,'logical');

for i = 1:H
    for j = 1:W
        %create the 8 nei index matrix
        nei = [i-1,j;   i,j-1;   i+1,j;   i,j+1;
               i-1,j-1; i-1,j+1; i+1,j+1; i+1,j-1];
        %remove the unavaliable index
        k = nei(:,1)<=0  |  nei(:,2)<=0 | nei(:,1)>H | nei(:,2)>W;
        nei(k,:) = [];
        %turn x and y index into one dim dix array.
        nei_idx = (nei(:,1) - 1).* 144 + nei(:,2);
        %calculate the number of stationary and moving labels in the neighborhood
        Qs = sum(last_state(nei_idx) == 0);
        Qm = sum(last_state(nei_idx) == 1);
        
        %apply Markov adaptive thresold
        psi_k = (next_f(i,j) - prev_f(i,j)).^2;
        ada_tres = (2 * Sig.^2 * (log(theta * MrS) + (Qs - Qm)/T));
        MRF_res(i,j) = psi_k > ada_tres;

    end
end


end

