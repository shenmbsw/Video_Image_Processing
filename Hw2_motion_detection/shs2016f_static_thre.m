function det_res = shs2016f_static_thre(prev_f,next_f,Sig)
%SHS2016F_STATIC_THRE Summary of this function goes here
%   Detailed explanation goes here

theta=1;
MrS=5;
[H,W] = size(prev_f);
thre = 2 * Sig.^2 * log(theta * MrS);
thre_mat = repmat(thre,H,W);
Psi_k = next_f - prev_f;
det_res = Psi_k.^2 > thre_mat;

end

