#include <iostream>
#include <device_launch_parameters.h>
/**
 * query the gpu info
 */
int main1(){
	int deviceCount;
	cudaGetDeviceCount(&deviceCount);//传递deviceCount 的内存地址
	std::cout<<"device count:"<<deviceCount<<std::endl;
	for(int i=0;i<deviceCount;i++){
		cudaDeviceProp prop;
		cudaGetDeviceProperties(&prop,i);
		std::cout<<"device ："<<i<<":"<<prop.name<<std::endl;
		std::cout<<"global mem ："<<prop.totalGlobalMem/1024/1024<<"MB"<<std::endl;
		std::cout<<"sm number ："<<prop.multiProcessorCount<<std::endl;
		std::cout<<"shared mem per thread block ："<<prop.sharedMemPerBlock/1024<<"KB"<<std::endl;
		std::cout<<"max thread num per thread block ："<<prop.maxThreadsPerBlock<<std::endl;
		std::cout<<"register num per thred block ："<<prop.regsPerBlock<<std::endl;
		std::cout<<"max thread num per multi processor ："<<prop.maxThreadsPerMultiProcessor<<std::endl;
		std::cout<<"max wrap per multi processor ："<<prop.maxThreadsPerMultiProcessor/32<<std::endl;
	}




	return 0;
}
