#include <iostream>
#include <sys/time.h>

using namespace std;

__global__ void Plus(float A[],float B[],float C[],int n){
	int i = threadIdx.x+blockIdx.x*blockDim.x;
	C[i]=A[i]+B[i];
}

int main(){
	struct timeval start ,end;
	gettimeofday(&start,NULL);
	float *A,*B,*C,*Ad,*Bd,*Cd;
	int n=1024*1024;
	int size=n*sizeof(float);

	A=(float*)malloc(size);
	B=(float*)malloc(size);
	C=(float*)malloc(size);

	for(int i=0;i<n;i++){
		A[i]=90;
		B[i]=10;
	}

	cudaMalloc(&Ad,size);//传入Ad指针的地址，初始化Ad指针，指向分配的显存地址 void** 为了类型通用
	cudaMalloc((void **)&Bd,size);
	cudaMalloc((void **)&Cd,size);

	cudaMemcpy(Ad,A,size,cudaMemcpyHostToDevice);
	cudaMemcpy(Bd,B,size,cudaMemcpyHostToDevice);
	cudaMemcpy(Cd,C,size,cudaMemcpyHostToDevice);

	dim3 dimBlock(512);
	dim3 dimGrid(n/512); // 此处总共使用了1024 * 1024 个线程处理数据，每个数组元素对应一个thread，
	Plus<<<dimGrid,dimBlock>>>(Ad,Bd,Cd,n);

	cudaMemcpy(C,Cd,size,cudaMemcpyDeviceToHost);

	float error=0;
	for(int i=0;i<n;i++){
		error=fabs(100-C[i]);
	}
	cout<<"error is  "<<error<<endl;

	free(A);
	free(B);
	free(C);
	cudaFree(Ad);
	cudaFree(Bd);
	cudaFree(Cd);

	gettimeofday(&end,NULL);
	int timeuse=1000000*(end.tv_sec-start.tv_sec)+end.tv_usec-start.tv_usec;
	cout<<"time use:"<<timeuse/1000<<"ms"<<endl;


	return 0;
}
