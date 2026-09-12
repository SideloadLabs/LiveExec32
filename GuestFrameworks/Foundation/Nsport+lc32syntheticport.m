#import <Foundation/Foundation+LC32.h>

@implementation NSMachPort (LC32SyntheticPort)

/*
 * `machPort` here is a port *name* minted by LC32's own synthetic Mach
 * subsystem (see the "synthetic port" notes in dynarmic_syscalls.cpp) -- it
 * is not a real kernel port right and means nothing to the host kernel that
 * backs this NSMachPort. The generic bridge forwarded it verbatim into the
 * real +[NSMachPort portWithMachPort:], which the host kernel rejects,
 * yielding nil. Old titles that mint a reply/notify port this way (FIFA14's
 * background IPC-heartbeat thread does) only need *some* schedulable port to
 * hand to -[NSRunLoop addPort:forMode:] -- not that specific port identity --
 * so hand back a real, always-valid host-backed port instead of a bogus one.
 */
+ (NSPort *)portWithMachPort:(uint32_t)machPort {
    (void)machPort;
    return [[[NSMachPort alloc] init] autorelease];
}

+ (NSPort *)portWithMachPort:(uint32_t)machPort options:(NSUInteger)options {
    (void)machPort;
    (void)options;
    return [[[NSMachPort alloc] init] autorelease];
}

@end
