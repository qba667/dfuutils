#ifndef __DFU_BOOL_H__
#define __DFU_BOOL_H__

#include <stdint.h>

typedef uint32_t dfu_bool;
#define true 1
#define false 0
#ifdef _MSC_VER
#ifdef DFUUTILS_EXPORTS
#define DFUUTILS_API __declspec(dllexport)
#else
#define DFUUTILS_API __declspec(dllimport)
#endif
#include <SDKDDKVer.h>
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#else

#define DFUUTILS_API
#endif
#endif


