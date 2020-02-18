% Constants
N = 640;
allN = [40 80 160 320 640];
L = 1;
h = L/(N-1);
epsilon = 0;
T = 1;
k = h/2;

x = linspace(0,L,N); % Generate N elements between 0 and L
u = zeros(2*N,length(x));
u_x = zeros(length(x));

A = zeros(N) + diag(ones(1,N-1),1) + diag(-1.*ones(1,N-1),-1);
A(1,N-1) = -1;
A(end,2) = 1;



for i=1:N % Generate initial conditions
    u(1, i) = init(i*h);
end

t = 0;
i = 1;

while t<T
    k1 = k*runk(A,u(i,:)',h);
    k2 = k*runk(A,u(i,:)'+ k1/2,h);
    k3 = k*runk(A,u(i,:)' + k2/2,h);
    k4 = k*runk(A,u(i,:)' + k3,h);
    
    u(i,1) = u(i,end);
    u(i+1,:) = u(i,:) + (1/6).*(k1 + 2*k2 + 2*k3 + k4)';
    
%     plot(x,u(1,:),'r');
%     plot(x,u(i,:),'b',x,u(1,:),'r');
%     pause(k/2)
    
    uend = u(i+1,:);
    
    t = t + k;
    i = i + 1;
end

error = norm(uend-u(1,:));
h = 1./(allN-1);
error = [1.2450 1.5900 1.2937 0.6844 0.3131];


%%%%%%%% FUNCTIONS %%%%%%%%

function u0 = init(x) % Initial conditions
if abs(2*x-0.3) <= 0.25
    u0 = exp(-300*(2*x-0.3)^2);
else
    u0 = 0;
end
end

function fdot = runk(A,u,h)
fdot = -(1/(2*h)).* A*u;
end




