#ifndef __HS_LLVM_EXTRA_H__
#define __HS_LLVM_EXTRA_H__

extern int FCMP_OEQ();
extern int FCMP_OGT();
extern int FCMP_OGE();
extern int FCMP_OLT();
extern int FCMP_OLE();
extern int FCMP_ONE();
extern int FCMP_ORD();
extern int FCMP_UNO();
extern int FCMP_UEQ();
extern int FCMP_UGT();
extern int FCMP_UGE();
extern int FCMP_ULT();
extern int FCMP_ULE();
extern int FCMP_UNE();

extern int ICMP_EQ();
extern int ICMP_NE();
extern int ICMP_UGT();
extern int ICMP_UGE();
extern int ICMP_ULT();
extern int ICMP_ULE();
extern int ICMP_SGT();
extern int ICMP_SGE();
extern int ICMP_SLT();
extern int ICMP_SLE();

extern int writeBitCodeToFile(void* m,const char* path);

#endif