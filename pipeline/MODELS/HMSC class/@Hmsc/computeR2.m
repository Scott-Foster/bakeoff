function R2 = computeR2(m,predN)

predList = m.predict(predN, m.X, m.piCell, m.xyCell, true);
pred = mean(cat(3,predList{:}),3);
R2 = m.computeR2Pred(pred);

pred = predList{1};
for i=2:predN
	pred = pred+predList{i};
end
pred = pred / predN;

z=max(m.nr,1);
R2 = zeros(m.ns,z);
for level=1:z
	if(m.nr>0)
		nunits=max(m.pi(:,level));
	else
		nunits=0;
	end
	if(nunits==m.ny || m.nr==0)
		for j=1:m.ns
			R2(j,level) = mean(pred(m.Y(:,j)==1,j))-mean(pred(m.Y(:,j)==0,j));
		end
	else
		obs=zeros(nunits,m.ns);
		preds=zeros(nunits,m.ns);
		for j=1:nunits
			obs(j,:)=sum(m.Y(m.pi(:,level)==j,:));
			preds(j,:)=sum(pred(m.pi(:,level)==j,:));
		end
		for j=1:m.ns
			R2(j,level) = corr(obs(:,j),preds(:,j));
		end
	end
end
