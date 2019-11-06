echo "==============================================="
echo "=============Installing OVS-2.11.0============="
echo "==============================================="

echo "==============================================="
echo "=============Installing Dependencies First====="
echo "==============================================="

echo "=================="
echo "===In sudo mode==="
echo "=================="

yum install wget openssl-devel  python-sphinx gcc make python-devel openssl-devel kernel-devel graphviz kernel-debug-devel autoconf automake rpm-build redhat-rpm-config libtool python-twisted-core python-zope-interface PyQt4 desktop-file-utils libcap-ng-devel groff checkpolicy selinux-policy-devel -y
yum install gcc-c++ -y
yum install python-six -y
yum install unbound unbound-devel -y

echo "======================="
echo "===Creating OVS user==="
echo "======================="

su - ovs
echo "===Creating rpmbuild/SOURCES directory==="
mkdir -p ~/rpmbuild/SOURCES
echo "===downloading ovs-2.11.0 tar==="
wget http://openvswitch.org/releases/openvswitch-2.9.2.tar.gz
echo "===copy ovs.2.11.0.tar.gz to rpmbuild/SOURCES/==="
cp openvswitch-2.9.2.tar.gz ~/rpmbuild/SOURCES/
echo "===Extracting tar file==="
tar xfz openvswitch-2.9.2.tar.gz
rpmbuild -bb --nocheck openvswitch-2.11.0/rhel/openvswitch-fedora.spec
exit
echo "=================="
echo "===In sudo mode==="
echo "=================="

echo "=============================="
echo "===Installing OVS using rpm==="
echo "=============================="

yum localinstall /home/ovs/rpmbuild/RPMS/x86_64/openvswitch-2.9.2-1.el7.x86_64.rpm -y

echo "=========================================="
echo "===Start and Enable OPENVSWITCH Service==="
echo "=========================================="

systemctl start openvswitch.service
systemctl enable openvswitch.service

echo "===Checking Status of OVS==="
systemctl status openvswitch.service

echo "===Checking OVS Version==="
ovs-vsctl -V
