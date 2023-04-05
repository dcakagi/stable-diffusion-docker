from diffusers.pipelines.stable_diffusion.safety_checker import StableDiffusionSafetyChecker
from transformers import AutoFeatureExtractor

output_dir = "downloaded_model"
safety_model_id = "CompVis/stable-diffusion-safety-checker"
safety_feature_extractor = AutoFeatureExtractor.from_pretrained(safety_model_id)
safety_checker = StableDiffusionSafetyChecker.from_pretrained(safety_model_id)
safety_feature_extractor.save_pretrained(f"{output_dir}/feature_extractor")
safety_checker.save_pretrained(f"{output_dir}/checker")
