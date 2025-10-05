{
  python312Packages,
  writers,
}:
writers.writePython3Bin "nvidia-oc" {
  libraries = with python312Packages; [nvidia-ml-py pynvml];
} ''
  import pynvml as nv

  nv.nvmlInit()

  memval = 1800

  myGPU = nv.nvmlDeviceGetHandleByIndex(0)

  nv.nvmlDeviceSetPowerManagementLimit(myGPU, 260000)

  nv.nvmlDeviceSetMemClkVfOffset(myGPU, memval)

  nv.nvmlDeviceSetGpuLockedClocks(myGPU, 1800, 1800)
''
