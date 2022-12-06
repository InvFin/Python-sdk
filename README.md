# InvFinSDK
[![Documentation Status](https://readthedocs.org/projects/invfinsdk/badge/?version=latest)](https://invfinsdk.readthedocs.io/en/latest/?badge=latest)
[![PyPI](https://img.shields.io/pypi/dm/invfinsdk.svg)](https://pypi.python.org/pypi)
[![PyPI](https://img.shields.io/pypi/v/invfinsdk.svg)](https://pypi.python.org/pypi)

An SDK to interact with InvFin endpoints


* Free software: MIT license
* Documentation: https://invfinsdk.readthedocs.io.


## Support Methods

- [Company](https://inversionesyfinanzas.xyz/api/api-documentacion/#lista-de-terminos)
- [Exchange](https://inversionesyfinanzas.xyz/api/api-documentacion/#lista-de-exchanges)
- [Term](https://inversionesyfinanzas.xyz/api/api-documentacion/#lista-de-terminos)
- [Industry](https://inversionesyfinanzas.xyz/api/api-documentacion/#lista-de-terminos)
- [Sector](https://inversionesyfinanzas.xyz/api/api-documentacion/#lista-de-terminos)
- [Superinvestor](https://inversionesyfinanzas.xyz/api/api-documentacion/#superinversores)


## User installation

The easiest way to install invfinsdk is using ``pip``:

    pip install -U invfinsdk


## How to use it

    from invfinsdk import Company

    API_KEY = "******"

    aapl = Company(API_KEY).get_company_basic_information({"ticker": "AAPL"})


## Source code

You can check the latest sources with the command:

    git clone https://github.com/InvFin/Python-sdk.git


## Testing

After installation, you can launch the test suite from outside the source
directory (you will need to have ``pytest`` installed):

    pytest invfinsdk


## Contributing

Welcome! Happy to see you willing to make the project better. You can get started by
reading this:

[Contributing: The basics](https://github.com/InvFin/Python-sdk/blob/main/CONTRIBUTING.rst)


## Changelog

The log has become rather long. It moved to its own file.

See [CHANGES](https://github.com/InvFin/Python-sdk/blob/main/HISTORY.rst).


## Authors

The author list is quite long nowadays, so it lives in its own file.

See [AUTHORS.rst](./AUTHORS.rst)