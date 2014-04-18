from hashlib import md5

def md5_file(url):
    m = md5()
    rpm_file = open(url,'rb')
    m.update(rpm_file.read())
    rpm_file.close()
    return m.hexdigest()

def loop_files(url):
    f = open(url)
    line = f.readline()
    while line:
        #print line
        rpm = line.strip('\n')
        vsm =  md5_file('/usr/local/wgc/vsmrepo/x86_64/'+rpm)
        centos = md5_file('/usr/local/wgc2/centos/Packages/'+rpm)
        if(vsm == centos):
            print rpm
        line = f.readline()
loop_files('repeat.txt')
#print md5_file('/root/wgc/repeat.txt')
