$Path = '.\Bin\NVIDIA-Suprminer\ccminer.sln'
$Uri = 'https://github.com/ocminer/suprminer/archive/1.6.zip'

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Algorithms = [PSCustomObject]@{
    #Lyra2z = 'lyra2z'
    #Equihash = 'equihash' #not supported
    #Cryptonight = 'cryptonight'
    #Ethash = 'ethash' #not supported
    #Sia = 'sia'
    #Yescrypt = 'yescrypt'
    #BlakeVanilla = 'vanilla'
    #Lyra2RE2 = 'lyra2v2'
    #Skein = 'skein'
    #Qubit = 'qubit'
    #NeoScrypt = 'neoscrypt'
    #X11 = 'x11'
    #MyriadGroestl = 'myr-gr'
    #Groestl = 'groestl'
    #Keccak = 'keccak'
    #Scrypt = 'scrypt'
    #Bitcore = 'bitcore'
    #Blake2s = 'blake2s'
    #Sib = 'sib'
    x17= 'x17'
    #Quark = 'quark'
    #Hmq1725 = 'hmq1725'
    #Veltor = 'veltor'
    #X11evo = 'x11evo'
    #Timetravel = 'timetravel'
    #Blakecoin = 'blakecoin'
    #Lbry = 'lbry'
    #Jha = 'jha'
    #Skunk = 'skunk'
    #Tribus = 'tribus'
    #Phi = 'phi'
    #Hsr = 'hsr'
    #Polytimos = 'polytimos'
    #Decred = 'decred'
    X16r = 'x16r'
    X16s = 'x16s'
}

$Optimizations = [PSCustomObject]@{
    Lyra2z = ' --api-remote --api-allow=0/0 --submit-stale'
    Equihash = ''
    Cryptonight = ' -i 10 --api-remote --api-allow=0/0'
    Ethash = ''
    Sia = ''
    Yescrypt = ''
    BlakeVanilla = ''
    Lyra2RE2 = ' --api-remote --api-allow=0/0'
    Skein = ''
    Qubit = ''
    NeoScrypt = ''
    X11 = ''
    MyriadGroestl = ''
    Groestl = ''
    Keccak = ' --api-remote --api-allow=0/0'
    Scrypt = ''
    Bitcore = ' --api-remote --api-allow=0/0'
    Blake2s = ''
    Sib = ''
    X17 = ''
    Quark = ''
    Hmq1725 = ' --api-remote --api-allow=0/0'
    Veltor = ''
    X11evo = ' --api-remote --api-allow=0/0'
    Timetravel = ' --api-remote --api-allow=0/0'
    Blakecoin = ''
    Lbry = ''
    Jha = ' --api-remote --api-allow=0/0'
    Skunk = ' --api-remote --api-allow=0/0'
    Tribus = ' --api-remote --api-allow=0/0'
    Phi = ' -i 23 --api-remote --api-allow=0/0'
    Hsr = ' --api-remote --api-allow=0/0'
    Polytimos = ' --api-remote --api-allow=0/0'
    Decred = ' --api-remote --api-allow=0/0'
    X16r = ''
    X16s = ''
    
}


$Commands | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name | ForEach-Object {
    [PSCustomObject]@{
        MinerName = "ccminer"
	Type = "NVIDIA"
        Path = $Path
        Arguments = "-a $_ -o stratum+tcp://$($Pools.(Get-Algorithm($_)).Host):$($Pools.(Get-Algorithm($_)).Port) -u $($Pools.(Get-Algorithm($_)).User) -p $($Pools.(Get-Algorithm($_)).Pass)$($Commands.$_)"
        HashRates = [PSCustomObject]@{(Get-Algorithm($_)) = $Stats."$($Name)_$(Get-Algorithm($_))_HashRate".Day}
        API = "Ccminer"
        Port = 4068
        Wrap = $false
        URI = $Uri
    }
}