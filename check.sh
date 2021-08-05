#!/bin/bash
clear
YL="\033[1;33m"
W="\033[37;1m"
B="\033[0;36m"
R="\033[31;1m"
GL="\033[32;1m"
P="\033[35;1m"
echo -e "$W""========================"
echo -e "$YL"" _____           _
|_   _|__   ___ | |___
  | |/ _ \ / _ \| / __|
  | | (_) | (_) | \__ \
  
  |_|\___/ \___/|_|___/"
echo ""
echo -e "$P""  PONDASI BUILD KERNEL""$W"
echo "========================"
echo -e "$B""Download & Install Tools cmake, llvm-clang, AnyKernel3 & NDK toolchain"
cd $HOME
echo ""
echo -e "$YL"“Update aplikasi dulu biar afdol”
echo -e "$W"
sudo apt-get update
echo -e "$YL""install untuk dependencies"
echo -e "$W"
sudo apt-get install python3 git cmake clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm python-clang build-essential make bzip2 libncurses5-dev lld libssl-dev python3-pip ninja-build 
pip3 install psutil
clear
echo -e "$YL"" Dependencies berhasil terinstal"
echo -e "$W" "================================"
echo -e "$P""  ____ __  __    _    _  _______
 / ___|  \/  |  / \  | |/ / ____|
| |   | |\/| | / _ \ | ' /|  _|
| |___| |  | |/ ___ \| . \| |___
 \____|_|  |_/_/   \_\_|\_\_____|"
echo -e "$W" "================================"
echo -e "$YL""    install & membangun cmake"
echo -e "$W"
read -p " Tekan Y Untuk melanjutkan:" pil;
echo ""
if [ $pil=Y/y ];
then
cd $HOME
git clone https://gitlab.kitware.com/cmake/cmake.git
sudo chmod +x cmake* && cd cmake* && sudo chmod +x bootstrap && ./bootstrap && make -j$(nproc --all) && sudo make install
echo -e "$YL""install cmake selesai"
else
echo -e "$R" 
echo "Opsi pilihan salah..!!" 
echo""
exit
fi
cd $HOME
echo "Download Tools AnyKernel3 AK3"
echo -e "$W"
git clone https://github.com/osm0sis/AnyKernel3.git
clear
echo -e "$YL"" Tools AK3 selesai terdownload"
echo -e "$W" "================================"
echo -e "$P""  ____ _        _    _   _  ____
 / ___| |      / \  | \ | |/ ___|
| |   | |     / _ \ |  \| | |  _
| |___| |___ / ___ \| |\  | |_| |
 \____|_____/_/   \_\_| \_|\____|"
echo -e "$W" "================================"
echo -e "$YL""  install & membangun llvm clang"
echo -e "$W"
read -p " Tekan ya Untuk melanjutkan:" pil;
echo ""
if [ $pil=ya/Ya ];
then
cd $HOME
git clone https://github.com/llvm/llvm-project.git
cd $HOME/llvm-project
else
echo -e "$R" 
echo "Opsi pilihan salah..!!" 
echo""
exit
fi
echo -e "$YL""Membuat folder build"
echo -e "$W"
mkdir -v build && cd build
clear
echo ""
echo -e "$YL""SILAHKAN PILIH GENERATOR UNTUK MEMBANGUN CLANG";
echo -e "$W""-----------------------------------------"
echo -e "$P""1). Tools Generator Unix Makefiles";
echo -e "$W""-----------------------------------------"
echo ""
echo "-----------------------------------------"
echo -e "$P""2). Tools Generator Ninja ";
echo -e "$W""-----------------------------------------"
echo ""
echo "-----------------------------------------"
echo -e "$P""3). Keluar";
echo -e "$W""-----------------------------------------" "$P"
read -p "Pilihan anda [1-3] :" pil;
echo ""

if [ $pil -eq 1 ];
then
echo -e "$YL""Bangun clang dgn Generator Unix Makefile"
echo -e "$W"
make_build_unix() {
cmake -DCMAKE_BUILD_TYPE=Release \ -DLLVM_ENABLE_PROJECTS="clang" \ -DLLVM_USE_LINKER=lld -G "Unix  Makefiles" ../llvm
make -j$(nproc --all)
make install
echo -e "$YL""Test clang utk memastikan sdh terinstall"
echo -e "$W"
make check-all
}
make_build_unix

elif [ $pil -eq 2 ];
then
echo -e "$YL""Bangun clang dgn Generator Ninja"
make_build_ninja() {
cmake -DCMAKE_BUILD_TYPE=Release \ -DLLVM_ENABLE_PROJECTS="clang" \ -DLLVM_USE_LINKER=lld -G Ninja ../llvm
ninja -j$(nproc --all)
ninja install
echo -e "$YL""Test clang utk memastikan sdh terinstall"
echo -e "$W"
ninja check-all
} 
make_build_ninja

elif [ $pil -eq 3 ]; 
then
echo ""
echo -e "$W""Terima kasih & Sampai Jumpa"
echo ""
exit 0
else
echo "" 
echo -e "$R""Opsi pilihan anda salah..!!"
echo ""
exit 1
fi
cd $HOME
echo -e "$YL""install clang berhasil"
echo -e "$W""========================"
echo -e "$P""Silahkan Download manual Tools  Android NDK toolchain"
echo "klik link https://developer.android.com/ndk/downloads"
echo "Pilih Linux 64 bit x86 - android-ndk-r21b-linux-x86_64.zip utk hp arsitektur 64bit"
echo "Extract android-ndk-r21b-linux-x86_64.zip ke dalam folder $HOME"
echo "Selanjutnya tinggal ikuti tutornya di dlm video & jgn di skip agar tdk gagal paham"
echo -e "$B" "Good Luck"

