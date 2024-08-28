from typing import Tuple, Union


def validate(job_params: dict) -> Tuple[bool, Union[bytes, None]]:
    if 'sample_experiment' not in job_params:
        return False, '`sample_experiment` is required for blast compute request'

    valid_experiment_samples = ['SRR2931415', 'SRR5139395', 'ERR018507_1', 'ERR018501_1', 'ERR018491_1']
    if job_params['sample_experiment'] not in valid_experiment_samples:
        return False, f'Unknown sample experiment: {job_params["sample_experiment"]}. Please use one of {", ".join(valid_experiment_samples)}'

    return True, None