# compkg.sh

compkg.sh searches packagist.org for packages to use with composer.phar

## Issues

- Currently only works on OSX but can be fixed with a simple path modification in file itself.

## Dependencies
- [cURL](https://github.com/bagder/curl)
- [jshon](https://github.com/keenerd/jshon)

## Usage

- Navigate to directory containing `compkg.sh`
- Make `compkg.sh` executable
- Run it and follow the steps.

```bash
cd /path/to/compkg-directory
chmod +x compkg.sh
./compkg.sh
```

## Notes

- Homebrew is recommended to install dependencies
- An audit feature to detect dependencies is planned for future versions

 
