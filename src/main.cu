//https://devblogs.nvidia.com/easy-introduction-cuda-c-and-c/

#include <stdio.h>
#include <cuda.h>

int main(void)
{
    int runtimeVersion = -1;
    cudaError_t error_id = cudaRuntimeGetVersion(&runtimeVersion);

    printf("Runtime version %d; Cuda error: %x (%s)\n", runtimeVersion, error_id, cudaGetErrorString(error_id));

    int driverVersion = -1;
    error_id = cudaDriverGetVersion(&driverVersion);

    printf("Driver version %d; Cuda error: %x (%s)\n", driverVersion,error_id, cudaGetErrorString(error_id));

    int deviceCount = -1;
    error_id = cudaGetDeviceCount(&deviceCount);

    printf("Device count %d; Cuda error: %x (%s)\n", deviceCount, error_id, cudaGetErrorString(error_id));
}
