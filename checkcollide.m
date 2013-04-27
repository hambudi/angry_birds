function [ collide ] = checkcollide(E)
len = length(E);
collide = zeros(len,len,4);
% vect = [];
A = zeros(len,2);
B = zeros(len,2);
C = zeros(len,2);
for i =1:len
%     disp('startnow')
%     disp(i)
%     disp(A)
%     disp(E(i).Ar2')
    A(i,:)=E(i).Ar2';
    B(i,:)=E(i).Br2';
    C(i,:)=E(i).center2';
end
AA = A*A';
AB = A*B';
AC = A*C';
BB = B*B';
BC = B*C';

tol = 1.0000;

for i = 1:len
    for j = 1:len
        a=0;
        b=0;
        c=0;
        d=0;
        if i == j
          continue
        end
        if ((AC(i,j)-AB(i,j)-AA(i,j))/AA(i,i)) <= ((AC(i,i)/AA(i,i)) + tol)...
        && ((AC(i,j)-AB(i,j)-AA(i,j))/AA(i,i)) >= ((AC(i,i)/AA(i,i)) - tol)
            a=a+1;
        end
        if ((BC(i,j)-BB(i,j)-AB(j,i))/BB(i,i)) <= ((BC(i,i)/BB(i,i)) +  tol)...
        && ((BC(i,j)-BB(i,j)-AB(j,i))/BB(i,i)) >= ((BC(i,i)/BB(i,i)) -  tol)
        	a=a+1;
        if a ==2
            collide(i,j,3)=1;
        end
        end 
        
        
        if ((AC(i,j)+AB(i,j)-AA(i,j))/AA(i,i)) <= ((AC(i,i)/AA(i,i)) +  tol)...
        && ((AC(i,j)+AB(i,j)-AA(i,j))/AA(i,i)) >= ((AC(i,i)/AA(i,i)) -  tol)
            b=b+1;
        end
        if ((BC(i,j)+BB(i,j)-AB(j,i))/BB(i,i)) <= ((BC(i,i)/BB(i,i)) +  tol)...
        && ((BC(i,j)+BB(i,j)-AB(j,i))/BB(i,i)) >= ((BC(i,i)/BB(i,i)) -  tol)
            b=b+1;
            if b ==2
                collide(i,j,2)=1;
            end
        end    
        
        
        if ((AC(i,j)+AB(i,j)+AA(i,j))/AA(i,i)) <= ((AC(i,i)/AA(i,i)) +  tol)...
        && ((AC(i,j)+AB(i,j)+AA(i,j))/AA(i,i)) >= ((AC(i,i)/AA(i,i)) -  tol)
            c=c+1;

        end
        if ((BC(i,j)+BB(i,j)+AB(j,i))/BB(i,i)) <= ((BC(i,i)/BB(i,i)) +  tol)...
        && ((BC(i,j)+BB(i,j)+AB(j,i))/BB(i,i)) >= ((BC(i,i)/BB(i,i)) -  tol)
            c=c+1;
            if c ==2
                collide(i,j,1)=1;
            end
        end    
            
            
            
        if ((AC(i,j)-AB(i,j)+AA(i,j))/AA(i,i)) < ((AC(i,i)/AA(i,i)) +  tol)...
        && ((AC(i,j)-AB(i,j)+AA(i,j))/AA(i,i)) > ((AC(i,i)/AA(i,i)) -  tol)
            d=d+1;

        end
        if ((BC(i,j)-BB(i,j)+AB(j,i))/BB(i,i)) < ((BC(i,i)/BB(i,i)) +  tol)...
        && ((BC(i,j)-BB(i,j)+AB(j,i))/BB(i,i)) > ((BC(i,i)/BB(i,i)) -  tol)
            d=d+1;
            if d ==2
                collide(i,j,4)=1;
            end
        end
    end
end
end
            
