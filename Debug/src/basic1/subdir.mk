################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CU_SRCS += \
../src/basic1/add.cu \
../src/basic1/deviceQuery.cu 

CU_DEPS += \
./src/basic1/add.d \
./src/basic1/deviceQuery.d 

OBJS += \
./src/basic1/add.o \
./src/basic1/deviceQuery.o 


# Each subdirectory must supply rules for building sources it contributes
src/basic1/%.o: ../src/basic1/%.cu
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/usr/local/cuda-8.0/bin/nvcc -G -g -O0 -gencode arch=compute_50,code=sm_50  -odir "src/basic1" -M -o "$(@:%.o=%.d)" "$<"
	/usr/local/cuda-8.0/bin/nvcc -G -g -O0 --compile --relocatable-device-code=true -gencode arch=compute_50,code=sm_50  -x cu -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


