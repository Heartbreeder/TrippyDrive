using UnityEngine;
using System.Collections;
using System.Collections.Generic;

[ExecuteInEditMode]
public class ImageEffects : MonoBehaviour
{
    public RenderTexture PreviousFrameBuffer;
    public Material TrippyMaterial;
    public Material DisplacementMaterial;

    void OnRenderImage(RenderTexture src, RenderTexture dst)
    {
        RenderTexture temp = RenderTexture.GetTemporary(src.width, src.height, 0);
        RenderTexture temp2 = RenderTexture.GetTemporary(src.width, src.height, 0);

        Graphics.Blit(src, temp, DisplacementMaterial);

        TrippyMaterial.SetTexture("_PrevFrame", PreviousFrameBuffer);
        Graphics.Blit(temp, temp2, TrippyMaterial);
        Graphics.Blit(temp2, PreviousFrameBuffer);
        Graphics.Blit(temp2, dst);

        RenderTexture.ReleaseTemporary(temp);
    }
}