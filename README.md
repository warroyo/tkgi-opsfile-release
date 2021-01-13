# TKGI Opsfile Release

this enables an operator to configure a bosh opsfile that will be written to the tkgi api vm and can then be used against cluster creation for ovverding deployment settings. this needs to be used in conjunction with the sccript included to add the opsfile to the tile metadata.

this was initially written to override the `vm_strategy` for tkgi clusters

## Usage 

add any opsfile contents to the addon.yml an example is given with `vm_strategy` in the `addon-vmstrategy-example.yml`

### Install

1. Open a shell prompt on a BOSH CLI with access to your PKS bosh director, such as Ops Manager.
2. Export your BOSH credentials to the enviornment.  These can be accessed via the Ops Manager GUI -> BOSH Director Tile -> Credentials Tab -> Bosh Commandline Credentials.

e.g.
```
export BOSH_CLIENT=ops_manager BOSH_CLIENT_SECRET=fakesecret BOSH_CA_CERT=/var/tempest/workspaces/default/root_ca_certificate  BOSH_ENVIRONMENT=10.0.0.10
```
3. Copy or clone this repository onto this BOSH CLI workstation and create+upload the BOSH release to the director

```
git clone https://github.com/warroyo/tkgi-opsfile-release && cd tkgi-opsfile-release
bosh create-release --force
bosh upload-release ./dev_releases/os-conf/os-conf-21.0.0+dev.1.yml

```
4. Configure the addon from this repo
```
cd ..
bosh -n update-config --name=tkgi-opsfile --type=runtime ./addon.yml
```

1. modify the TKGI tile metadata to include the new file. run the below from the opsman vm.

```
./update-tile.sh
```

7. apply changes in opsman

8. update existing clusters to get the new settings.
